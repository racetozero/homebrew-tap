class M365 < Formula
  desc "m365: a fast native port of the CLI for Microsoft 365"
  homepage "https://github.com/racetozero/microsoft-365-cli"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.2/m365-aarch64-apple-darwin.tar.gz"
      sha256 "b7919d5b631347dfaf123c9ce4f7233c26446ed9b4a568fa021630a07c8da071"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.2/m365-x86_64-apple-darwin.tar.gz"
      sha256 "fc1a069db54e12225fb9c3d940fe1cea68a1330be45723cc297b865ec9794bf6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.2/m365-aarch64-unknown-linux-musl.tar.gz"
      sha256 "167dc578fa66ac863793ca41c714270795b8f483de6fb747b3b0eba04a0871c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/microsoft-365-cli/releases/download/v0.0.2/m365-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f1dcaa421c05251609c745380eea5e9b9a723deca6e2e8025cdba99f2ab88e6e"
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
