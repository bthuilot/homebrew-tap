class Dockerleaks < Formula
  desc "dockerleaks"
  homepage "https://github.com/bthuilot/dockerleaks"
  version "1.1.0"
  license "GPL-3"

 
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bthuilot/dockerleaks/releases/download/v#{version}/dockerleaks-v#{version}-darwin-amd64.tar.gz"
    sha256 "f2bdf746c4e402d398b437bae47b941ccf66582da534e5eaac5baaa5e637d763"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bthuilot/dockerleaks/releases/download/v#{version}/dockerleaks-v#{version}-darwin-arm64.tar.gz"
    sha256 "e774d1f2eb0e35f61928890976d9ec70a7446a959c0e221ca8e0b24ef7a3a5de"
  end

  def install
    bin.install "dockerleaks"
  end

  test do
    system "#{bin}/dockerleaks --help"
  end
end
