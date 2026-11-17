class DiscordPurge < Formula
  desc "Delete your own Discord messages from a TUI, web panel, or script"
  homepage "https://github.com/racetozero/discord-purge"
  version "0.0.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.4/discord-purge-aarch64-apple-darwin.tar.gz"
      sha256 "7b5104d693747c2a3ff84265bbd9c0f9ba644ef2e5631a46f098044e9e807bce"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.4/discord-purge-x86_64-apple-darwin.tar.gz"
      sha256 "9a46e122bc0f5f541f2310f259feb915d457e4f25d9bed9eb864659a5ed7613e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.4/discord-purge-aarch64-unknown-linux-musl.tar.gz"
      sha256 "52b145e3e6238b1414d372c05fda891dc6f71fa9edfaf77f7665e21ca76a7665"
    end
    on_intel do
      url "https://github.com/racetozero/discord-purge/releases/download/v0.0.4/discord-purge-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b515ba0843609b5fd047d12dfe2044a9b9d22b95ee2f6562d40107d075d2f0df"
    end
  end

  def install
    bin.install "discord-purge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/discord-purge --version")
  end
end
