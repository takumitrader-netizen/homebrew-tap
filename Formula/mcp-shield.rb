class McpShield < Formula
  desc "Privacy-first security scanner for MCP servers"
  homepage "https://github.com/takumitrader-netizen/mcpshield-ai"
  url "https://github.com/takumitrader-netizen/mcpshield-ai/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4560f2bb96f089f7a0d5f3aeebd8b11349482093fe5edf09d79a7c8cfd815966"
  license "Apache-2.0"

  head "https://github.com/takumitrader-netizen/mcpshield-ai.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = shell_output("#{bin}/mcp-shield info")
    assert_match "MCP Shield", output
    assert_match version.to_s, output
  end
end
