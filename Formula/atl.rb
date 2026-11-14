class Atl < Formula
  desc "atl: one CLI and MCP server for Jira, Confluence, Bitbucket, Trello and Atlassian Admin, Cloud and Data Center"
  homepage "https://github.com/racetozero/atlassian-toolkit"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.1/atl-aarch64-apple-darwin.tar.gz"
      sha256 "cc4a5c0a73a721c6a2010d416ae2208f31497b43e75fab7f09a871b4206c5cb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.1/atl-x86_64-apple-darwin.tar.gz"
      sha256 "e81bd596e48e3433e2e05f306719351f333c8ed0b476b48dbe8ba732b8f4cbff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.1/atl-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b7f314cb44eab2b06a575cdc140fbc226611bdbb721dc2c88128e145477caadb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.1/atl-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1266c2a35f4c767e9efbcdd0b04bcd8abd96d7a2e3fbb45ca726a947d784554a"
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
