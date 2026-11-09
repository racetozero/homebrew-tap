class Kiss < Formula
  desc "kiss: a fast, minimal terminal coding agent"
  homepage "https://github.com/racetozero/kiss"
  version "0.0.38"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.38/kiss-aarch64-apple-darwin.tar.gz"
      sha256 "07f9fcb91f3b97502758591ddfd1f237f282d9e8d1ab6fdbaaa30df668c37e46"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.38/kiss-x86_64-apple-darwin.tar.gz"
      sha256 "f14990fcd7b06f0cef1acee09bcd8d4a2b53836da90f061120672a3442ea63b7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.38/kiss-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d281565a623acdda10988f6c8566f06ca6edaeb024890baa3e8ff29e9bb25408"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.38/kiss-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0edd67f1f7db028a2c0cb74f3f2bb9c69f6f82c5fc16975157c07fbca3bdb588"
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
      bin.install "kiss"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kiss"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kiss"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kiss"
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
