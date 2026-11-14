class Atl < Formula
  desc "atl: one CLI and MCP server for Jira, Confluence, Bitbucket, Trello and Atlassian Admin, Cloud and Data Center"
  homepage "https://github.com/racetozero/atlassian-toolkit"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.2/atl-aarch64-apple-darwin.tar.gz"
      sha256 "bee71cf24a0100b707a43d1633d6ea4f110b0b75350a76888e102a8bc1b47aad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.2/atl-x86_64-apple-darwin.tar.gz"
      sha256 "bb8678d4070888e8f8f3640c16a91486da703934c6ca7cab2c2af43debce05bc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.2/atl-aarch64-unknown-linux-musl.tar.gz"
      sha256 "735c4460931947704f659051d8ee176f3e542dca86dbd8cafdf7683bb79c9d75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.2/atl-x86_64-unknown-linux-musl.tar.gz"
      sha256 "92aab4ee7f1f982543992255ee9789d2f1721ec2d557d1206c61e7b7558c344a"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "atl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "atl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "atl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "atl"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
