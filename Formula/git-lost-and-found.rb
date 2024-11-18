class GitLostAndFound < Formula
  desc "Script to find dangling commits in git repositories"
  homepage "https://github.com/bthuilot/git-lost-and-found"
  version "1.0.1"
  license "GPL-3.0-or-later"
  url "https://github.com/bthuilot/git-scanner/archive/refs/tags/v#{version}.tar.gz"
  sha256 "88f4ec6508e38057c5675d856209a2c26a2d963824fbb12a7ebc6bd5744b326d"
  head "https://github.com/bthuilot/git-lost-and-found.git", branch: "main"

  depends_on "go" => :build
  depends_on "gitleaks" => :recommended
  depends_on "trufflehog" => :recommended
  

  def install
    system "go", "build", *std_go_args(ldflags:"-s -w")

    generate_completions_from_executable(bin/"git-lost-and-found", "completion")
  end
  
  test do
    system "#{bin}/git-lost-and-found --help"
  end
end
