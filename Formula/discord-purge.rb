class DiscordPurge < Formula
  desc "Delete your own Discord messages from a TUI, web panel, or script"
  homepage "https://github.com/racetozero/discord-purge"
  version "0.0.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.3/discord-purge-aarch64-apple-darwin.tar.gz"
      sha256 "4313351363bf355adc503e48fb8e0b9276084c3856e2ca4fa9085e8cf0312c53"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.3/discord-purge-x86_64-apple-darwin.tar.gz"
      sha256 "d774c709d8f7de8e392ab20df7fd1fb20970bd32b1914418829b5966bf269c0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.3/discord-purge-aarch64-unknown-linux-musl.tar.gz"
      sha256 "39629b586d65e89839091691c46eb5985e530f28b6725166e945bad8fa82b846"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.3/discord-purge-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3e9ce96695d76542344f33f6f116591c007da5c264a64fd7f58a7cf3d09e2977"
    end
  end

  def install
    bin.install "discord-purge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discord-purge --version")
  end
end
