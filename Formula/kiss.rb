class Kiss < Formula
  desc "kiss: a fast, minimal terminal coding agent"
  homepage "https://github.com/racetozero/kiss"
  version "0.0.45"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.45/kiss-aarch64-apple-darwin.tar.gz"
      sha256 "5cc1f3cd91872e237b86013ba599c7058a28e4e0a996f807516ba1714147d646"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.45/kiss-x86_64-apple-darwin.tar.gz"
      sha256 "21ba66aa2e048deb066dfc651c68d00e8bf5f7fc22bdd45ef5ba2c532209ebb8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.45/kiss-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d77ba303cc6fdbb7416db534baacb83201bc31dfa73e3e22b3c320b04403dca1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.45/kiss-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3b09d2d87322f218d7afc8cf88c47a5ef0775a5eb6c871c66e419069ad0af539"
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
