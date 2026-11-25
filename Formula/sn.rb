class Sn < Formula
  desc "ServiceNow from the terminal: SSO sign-in, every REST API, agent mode, and a full-screen workspace"
  homepage "https://github.com/racetozero/servicenow-cli"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/servicenow-cli/releases/download/v0.0.1/sn-aarch64-apple-darwin.tar.gz"
      sha256 "1b639cc16372eba25a81b11ad42881e3429ee4706a2e6671001e594fa0af22ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/servicenow-cli/releases/download/v0.0.1/sn-x86_64-apple-darwin.tar.gz"
      sha256 "0bb84c176eabcbda2e9c9342ca3548e81e8788705fd7087ce834eaa44b774f75"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/servicenow-cli/releases/download/v0.0.1/sn-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5bced147cda5038aa6f8bf07b500c3f7fb99d75d368274f62a02fa3e112d1bb3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/servicenow-cli/releases/download/v0.0.1/sn-x86_64-unknown-linux-musl.tar.gz"
      sha256 "971e5aec761033abf301dffed3143b5d97b17e0206ff8e15636d6c463b97d90a"
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
      bin.install "sn"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sn"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sn"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sn"
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
