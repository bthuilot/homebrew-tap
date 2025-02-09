class GitLostAndFound < Formula
  desc "Script to find dangling commits in git repositories"
  homepage "https://github.com/bthuilot/git-lost-and-found"
  version "2.0.1"
  license "GPL-3.0-or-later"
  url "https://github.com/bthuilot/git-scanner/archive/refs/tags/v#{version}.tar.gz"
  sha256 "09c4410903bc531226ae868df78a4ec2f3d3910ff8ef59515e17cbc3062e203c"
  head "https://github.com/bthuilot/git-lost-and-found.git", branch: "main"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "gitleaks" => :recommended
  depends_on "trufflehog" => :recommended
  

  def install
    system "make", "build"
    bin.install "./bin/git-lost-and-found" => "git-lost-and-found"

    generate_completions_from_executable(bin/"git-lost-and-found", "completion")
  end
  
  test do
    system "#{bin}/git-lost-and-found --help"
  end
end
