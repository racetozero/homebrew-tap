class M365 < Formula
  desc "m365: a fast native port of the CLI for Microsoft 365"
  homepage "https://github.com/racetozero/microsoft-365-cli"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.1/m365-aarch64-apple-darwin.tar.gz"
      sha256 "eea8dbf8c04a389b02e23ab4ea9c52d4fff7f5559f02b43f7e7345b9c51a61cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.1/m365-x86_64-apple-darwin.tar.gz"
      sha256 "ba1be466b5b45690d3b07ee97351995fdafe9eea9232bbff5668d8d340c7bcc7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.1/m365-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bcfb53dd3d19960d40852d6d2dfb43bd7df4dd67f03fd082df78dc704d8bcb95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.1/m365-x86_64-unknown-linux-musl.tar.gz"
      sha256 "535b63e8aa13f21fdf98d3c03706ada601b46211672fc29b5ad0d84139762676"
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
      bin.install "m365"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "m365"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "m365"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "m365"
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
