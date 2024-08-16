class GitScanner < Formula
  desc "Git scanner to find sensitive information in dangling commits"
  homepage "https://github.com/bthuilot/git-scanner"
  version "0.1.1"
  license "GPL-3.0-or-later"
  url "https://github.com/bthuilot/git-scanner/archive/refs/tags/v#{version}.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  head "https://github.com/bthuilot/git-scanner.git", branch: "main"

  depends_on "go" => :build
  depends_on "gitleaks" => :recommended
  depends_on "trufflehog" => :recommended
  

  def install
    system "go", "build", *std_go_args(ldflags:"-s -w")

    generate_completions_from_executable(bin/"git-scanner", "completion")
  end
  
  test do
    system "#{bin}/git-scanner --help"
  end
end
