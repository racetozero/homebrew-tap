class Kiss < Formula
  desc "kiss: a fast, minimal terminal coding agent"
  homepage "https://github.com/racetozero/kiss"
  version "0.0.35"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.35/kiss-aarch64-apple-darwin.tar.gz"
      sha256 "6da91bf1105a175af1db906629816829ce4988bf2687a7c1146f5eb26bd368ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.35/kiss-x86_64-apple-darwin.tar.gz"
      sha256 "2f5cf184ac29f30db359e86177b59074e85c9c0d396ad468300505586067c556"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.35/kiss-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "80538315e96ef910d9c6f6fb95b19014650968598a790556c82ed0091fa64634"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.35/kiss-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9920e84b6e8df42c059e789d994a3c9851943c05f63b95991d53713918d7ddca"
    end
  end
  license "MIT"

  def install
    bin.install "kiss"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiss --version")
  end
end
