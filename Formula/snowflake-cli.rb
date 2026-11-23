class SnowflakeCli < Formula
  desc "snow: a fast, identical Rust port of Snowflake CLI"
  homepage "https://github.com/racetozero/snowflake-cli"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.1/snowflake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "c6cb4fd4556291d96a4386fb7d03cd2c922b0f63a5b75ee311472e3a4c2c1896"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.1/snowflake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "05760ceb6e7cc3b745f92162b415dad47e54311b2c79cd9defe63a1af86d5191"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.1/snowflake-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "40332c3510185c2c38cbc19691ada980c1534a8be62b0f496ecb849a2931a01b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.1/snowflake-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3a72507001152ccc6a4d2fa2df9e82d4ec3616170bee553ef28e762a6e2ff718"
    end
  end
  license "Apache-2.0"

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
      bin.install "snow"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "snow"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "snow"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "snow"
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
