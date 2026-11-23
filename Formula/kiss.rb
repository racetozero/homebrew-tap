class Kiss < Formula
  desc "kiss: a fast, minimal terminal coding agent"
  homepage "https://github.com/racetozero/kiss"
  version "0.0.43"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.43/kiss-aarch64-apple-darwin.tar.gz"
      sha256 "36c3524f73ec283361ba47e818076cf9306d27504bd64a8b6829d15ba697d0cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.43/kiss-x86_64-apple-darwin.tar.gz"
      sha256 "4477967092ced9525cbf1eae7adf28e76eddc030094a4c35af1adcf808570def"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.43/kiss-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b10d7d0b4caba5372b88e94e86b41de71e1bf57f96e99592927a31b3dbbda2fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.43/kiss-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6b08f03049c009f7bde51d28f872ef3166792595e30fb355f9b81c3e04d16cdc"
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
