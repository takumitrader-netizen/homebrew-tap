class McpShield < Formula
  desc "Privacy-first security scanner for MCP servers"
  homepage "https://mcpshieldai.com"
  # (audit S59 MED8) version is overwritten at release time by
  # scripts/update-homebrew-formula.sh, which reads the canonical version from
  # Cargo.toml (the single source of truth). Do NOT bump by hand. The value
  # here must match Cargo.toml or `brew test` will fail the `assert_match
  # version.to_s, output` assertion. Current release: 0.2.0.
  #
  # (S61) Bottles ship from the public binary-only releases repo
  # (takumitrader-netizen/mcp-shield-releases) rather than cdn.mcpshieldai.com.
  # Source-archive download is intentionally not supported — source is private.
  version "0.2.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/takumitrader-netizen/mcp-shield-releases/releases/download/v0.2.1/mcp-shield-aarch64-apple-darwin.tar.gz"
      sha256 "1be801a2cd28d2136e4d036bedf851e02872d07cfaf0bc55c76a006a16cefd9c"
    end

    on_intel do
      url "https://github.com/takumitrader-netizen/mcp-shield-releases/releases/download/v0.2.1/mcp-shield-x86_64-apple-darwin.tar.gz"
      sha256 "bdfe72e79a202bff7cd46604c3406bc90af029e3899b8a84bad12b5b70bb474f"
    end
  end

  on_linux do
    on_intel do
      # (audit S59 Batch 3) Default Linux x86_64 = glibc build (best perf,
      # smaller). Static-musl variant ships in the same release for older
      # distros (CentOS 7 / Alpine / scratch containers); Homebrew picks gnu
      # by convention.
      url "https://github.com/takumitrader-netizen/mcp-shield-releases/releases/download/v0.2.1/mcp-shield-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85c90239c5e93421f3e2b68dbd0acc791c79838c892b8fc7beaee4792f290021"
    end

    # (S61) Linux ARM64 (Graviton, Raspberry Pi 4+, ARM cloud) ships from
    # v0.3.0 onwards. The release matrix builds it; v0.2.0 was tagged before
    # the GitHub Releases mirror existed and shipped a partial CDN-only set.
    # update-homebrew-formula.sh will re-add an `on_arm` block here when the
    # aarch64-unknown-linux-gnu sidecar is present in the release artifacts.
  end

  def install
    bin.install "mcp-shield"
  end

  test do
    output = shell_output("#{bin}/mcp-shield info")
    assert_match "MCP Shield", output
    assert_match version.to_s, output
  end
end
