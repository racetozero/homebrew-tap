class Kiss < Formula
  desc "kiss: a fast, minimal terminal coding agent"
  homepage "https://github.com/racetozero/kiss"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.42/kiss-aarch64-apple-darwin.tar.gz"
      sha256 "daf035d9747e12bbff767a8aabca37861f7e0f0180189bc6f4d2f51ff717d1ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.42/kiss-x86_64-apple-darwin.tar.gz"
      sha256 "1ac94878fe51639a0ad1de3678c7c7f6ac45dd28401a3e133d65af42fa6b47e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.42/kiss-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0e5a2fcd42764334ee31002843c9cbb804dede6bb3df3395ac6ed2247c545a21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.42/kiss-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e4d502461a8fcab1ff466f0e6b294ad72cd1cff34af84094e67550463dcd0ad0"
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
