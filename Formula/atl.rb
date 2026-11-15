class Atl < Formula
  desc "atl: one CLI and MCP server for Jira, Confluence, Bitbucket, Trello and Atlassian Admin, Cloud and Data Center"
  homepage "https://github.com/racetozero/atlassian-toolkit"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.3/atl-aarch64-apple-darwin.tar.gz"
      sha256 "1e94034b7e823e476873c0b193c71b740be66d50cad4233dfef401f31f1c5321"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.3/atl-x86_64-apple-darwin.tar.gz"
      sha256 "ceb9dc7fcf2d59aec4d8b10ddd20dd0be957a5967e9008a9e8e1a95909fbf26e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.3/atl-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1b00a3e7101a0a7f30b8ba9baa124d07c708a86ce0b981b9f5ab1d224e96fd70"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/atlassian-toolkit/releases/download/v0.0.3/atl-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6a5be67b6e6d206432be3dc5591779bae542ac3067b868e08998386c5dc0dcc9"
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
