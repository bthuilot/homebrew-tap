class GitScanner < Formula
  desc "Git scanner to find sensitive information in dangling commits"
  homepage "https://github.com/bthuilot/git-scanner"
  version "0.1.0"
  license "GPL-3.0-or-later"
  url "https://github.com/gitleaks/git-scanner/archive/refs/tags/v#{version}.tar.gz"
  sha256 "fea36ca9a2220c66268530dbb97d4913824106802f8a1acaf04137895c4229f3"
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
