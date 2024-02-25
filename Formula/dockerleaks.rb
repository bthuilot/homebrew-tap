class Dockerleaks < Formula
  desc "dockerleaks"
  homepage "https://github.com/bthuilot/dockerleaks"
  version "1.3.0"
  license "GPL-3"

 
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bthuilot/dockerleaks/releases/download/v#{version}/dockerleaks-v#{version}-darwin-amd64.tar.gz"
    sha256 "732acecb0460f91e2fd41fdc3337c96221a97f6da32207e9360b7b9f9d37f41f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bthuilot/dockerleaks/releases/download/v#{version}/dockerleaks-v#{version}-darwin-arm64.tar.gz"
    sha256 "57db6f01e680f508f883d477d894f6b0cd7aa0cee119b7b76a795ca0424dd5c0"
  end

  def install
    bin.install "dockerleaks"
  end

  test do
    system "#{bin}/dockerleaks --help"
  end
end
