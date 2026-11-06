class DiscordPurge < Formula
  desc "Delete your own Discord messages from a TUI, web panel, or script"
  homepage "https://github.com/racetozero/discord-purge"
  version "0.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.2/discord-purge-aarch64-apple-darwin.tar.gz"
      sha256 "d77589f444ed74e8d47d608ce56f6dca33163be998de6a18ea95898bbbc9f3a3"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.2/discord-purge-x86_64-apple-darwin.tar.gz"
      sha256 "76dd3b61d99503686fac502ac53b09d92a4b1febdae5d4df0cc76c37ec6b6981"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.2/discord-purge-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d447deb35cae581e1504b2c38b9db8192322e1a5cd122c14b24b64c05422a052"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.2/discord-purge-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0a02e95beccf4cb6e594c3ca18d6d50489e93aeb61600af3158ba78bf900efdc"
    end
  end

  def install
    bin.install "discord-purge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discord-purge --version")
  end
end
