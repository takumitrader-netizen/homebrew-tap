class McpShield < Formula
  desc "Privacy-first security scanner for MCP servers"
  homepage "https://github.com/takumitrader-netizen/mcpshield-ai"
  url "https://github.com/takumitrader-netizen/mcpshield-ai/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "MCP Shield", shell_output("#{bin}/mcp-shield info")
  end
end
