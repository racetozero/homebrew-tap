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
      url "https://github.com/racetozero/kiss/releases/download/v0.0.35/kiss-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6920596c7e8c570f41539b85ca364985a8e76a222cf533eacdc5c71efa22ffc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/racetozero/kiss/releases/download/v0.0.35/kiss-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3fc050deb8c6737cc51bdf59e050f990df03b159ab407680e98a3ae85a343375"
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
