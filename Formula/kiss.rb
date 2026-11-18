class Kiss < Formula
  desc "kiss: a fast, minimal terminal coding agent"
  homepage "https://github.com/racetozero/kiss"
  version "0.0.41"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.41/kiss-aarch64-apple-darwin.tar.gz"
      sha256 "3c5a56572bda978aeb5305e93a5686e7ae27c10de12160f1352ad30a9419a6cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.41/kiss-x86_64-apple-darwin.tar.gz"
      sha256 "9d72a3f810e9c4ca5eb005d7581a30bce75bf86bd3620798d151abc8af3d0fd8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.41/kiss-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f301a161719387374b40017d5791f1b14a3cd75b42a8ca0664b5c1d2a7f63c54"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.41/kiss-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f51abccd5cb8dde4c3b5f6baa34c66868c115b47207972f6a34131e63af96552"
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
