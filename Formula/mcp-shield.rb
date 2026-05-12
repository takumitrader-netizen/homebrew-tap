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
  version "0.3.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/takumitrader-netizen/mcp-shield-releases/releases/download/v0.3.0/mcp-shield-aarch64-apple-darwin.tar.gz"
      sha256 "3cfd0fa9ec61888da5d69ffcb1e2571608a1f6ebe608a1d3db3ae1139945a448"
    end

    on_intel do
      url "https://github.com/takumitrader-netizen/mcp-shield-releases/releases/download/v0.3.0/mcp-shield-x86_64-apple-darwin.tar.gz"
      sha256 "e7e1f17f62ac89514b1f936df445bde44067585befbb0845657e6c296d03f5ca"
    end
  end

  on_linux do
    on_intel do
      # (audit S59 Batch 3) Default Linux x86_64 = glibc build (best perf,
      # smaller). Static-musl variant ships in the same release for older
      # distros (CentOS 7 / Alpine / scratch containers); Homebrew picks gnu
      # by convention.
      url "https://github.com/takumitrader-netizen/mcp-shield-releases/releases/download/v0.3.0/mcp-shield-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb67fe3a02ed892e19aac8946c66bbd54469b3bb8baf4e123944d480dd27fd2f"
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
