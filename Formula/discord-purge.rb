class DiscordPurge < Formula
  desc "Delete your own Discord messages from a TUI, web panel, or script"
  homepage "https://github.com/racetozero/discord-purge"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.1/discord-purge-aarch64-apple-darwin.tar.gz"
      sha256 "e39b9782ea3ed72188a2654576b9e69a82e2d43cf11d93b4f56288aa3a8e573a"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.1/discord-purge-x86_64-apple-darwin.tar.gz"
      sha256 "536d74f7c298faff9bd721e4617f7aed9ed072030697fc1f52b10b4954bf3cfe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.1/discord-purge-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b8746a408835a9a5831a8b53fc5c4bd3b5ad0da8850c04696ce3675aba1ee791"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.1/discord-purge-x86_64-unknown-linux-musl.tar.gz"
      sha256 "08ea870db39d26961b1578f8cdd0dbf944a92b52f534e6bd1220db8db4d9bd5a"
    end
  end

  def install
    bin.install "discord-purge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discord-purge --version")
  end
end
