class Dockerleaks < Formula
  desc "dockerleaks"
  homepage "https://github.com/bthuilot/dockerleaks"
  version "0.0.1"
  license "GPL-3"

 
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bthuilot/dockerleaks/releases/download/v0.0.1/dockerleaks-v0.0.1-darwin-amd64.tar.gz"
    sha256 "dfe441c165c26b12bb2070f06f1469fd8a9e93bdb4ba3d3ae2422d5b2e82b56b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bthuilot/dockerleaks/releases/download/v0.0.1/dockerleaks-v0.0.1-darwin-arm64.tar.gz"
    sha256 "345d4b272ea14862b1b97a3dba0f7e1c1a89c08d44adfb0b6765d32ca4cdf988"
  end

  def install
    bin.install "dockerleaks"
  end

  test do
    system "#{bin}/dockerleaks --help"
  end
end
