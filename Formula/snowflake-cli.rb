class SnowflakeCli < Formula
  desc "snow: a fast, identical Rust port of Snowflake CLI"
  homepage "https://github.com/racetozero/snowflake-cli"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.2/snowflake-cli-aarch64-apple-darwin.tar.gz"
      sha256 "f7fd13a8d07abce4178365948ac36113b432305b49ca02dfa33e531c631f4158"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.2/snowflake-cli-x86_64-apple-darwin.tar.gz"
      sha256 "3a0418399418a7619f7c9c6ee33e6521ae0ea428212ef973360d44bd97ca36cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.2/snowflake-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e35b54fb9500d21987f587569b6767ee16bb27f5e472243dd5aabb73ecf1db63"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/snowflake-cli/releases/download/v0.0.2/snowflake-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8c3d13ba6e2fa69ad4c18b127431f7e13523aaca8662e3b8614805b4e24d3c67"
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
