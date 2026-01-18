# frozen_string_literal: true

class GitLostAndFound < Formula
  VERSION = "2.2.0"

  desc "Script to find dangling commits in git repositories"
  homepage "https://github.com/bthuilot/git-lost-and-found"
  url "https://github.com/bthuilot/git-lost-and-found/archive/refs/tags/v#{version}.tar.gz"
  version VERSION
  sha256 "56407e645c521eb188cf7401cd90d76da63b7f98490b1a54412d61d4a6b2bc34"
  license "GPL-3.0-or-later"

  head "https://github.com/bthuilot/git-lost-and-found.git", branch: "main"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "gitleaks" => :recommended
  depends_on "trufflehog" => :recommended

  def install
    system "make", "build"
    bin.install "./bin/git-lost-and-found" => "git-lost-and-found"

    generate_completions_from_executable(bin / "git-lost-and-found", "completion")
  end

  test do
    system "#{bin}/git-lost-and-found", "--help"
  end
end
