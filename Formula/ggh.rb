# frozen_string_literal: true

ALL_HOOKS = %w[
  pre-commit
  commit-msg
  applypatch-msg
  post-update
  pre-merge-commit
  pre-receive
  update
  pre-applypatch
  pre-push
  prepare-commit-msg
  fsmonitor-watchman
  pre-rebase
  push-to-checkout
  post-commit
].freeze

class Ggh < Formula
  VERSION = "0.3.0"

  desc "Personalized global git hooks"
  homepage "https://github.com/bthuilot/ggh"
  url "https://github.com/bthuilot/ggh/archive/refs/tags/v#{VERSION}.tar.gz"
  sha256 "ea23c4c7271c08b05f7076b44af8c22b6e27d112672ec84fa21b03b4ed4015d2"
  license "GPL-3.0-or-later"

  depends_on "make" => :build
  depends_on "opam" => :build
  depends_on "git"

  # TODO(byce): support bottles
  # bottle do
  #   root_url "https://github.com/bthuilot/ggh/releases/download/v#{VERSION}/ggh-v#{VERSION}-darwin-arm64.tar.gz"
  #   sha256 cellar: :any_skip_relocation, arm64_sequoia: ""
  #   sha256 cellar: :any_skip_relocation, arm64_sonoma: ""
  #   sha256 cellar: :any_skip_relocation, arm64_ventura: ""
  #   sha256 cellar: :any_skip_relocation, arm64_monterey: ""
  #   sha256 cellar: :any_skip_relocation, big_sur: ""
  # end

  def install
    opamroot = buildpath / ".opam"
    opamroot.mkpath
    ENV["OPAMYES"] = "1"
    ENV["OPAMROOT"] = opamroot

    system "opam", "init", "--no-setup", "--disable-sandboxing", "--bare", "--"
    system "make", "build", "BUILDARGS=--release", "OPAMARGS="

    bin.install buildpath / "_build/default/bin/main.exe" => "ggh"

    hookspath = pkgshare / "hooks"
    hookspath.mkpath

    ALL_HOOKS.each do |hook|
      hookspath.install_symlink bin / "ggh" => hook
    end
  end

  def caveats
    hookspath = pkgshare / "hooks"
    <<~CAVEATS

      #########################
      # GGH IS NOT CONFIGURED #
      #########################

      WARNING: ggh is not currently configured to run as git hooks
      please run the following to set ggh as your global hooks

      $ git config set --global core.hooksPath "#{hookspath}"

      or edit your ~/.gitconfig to contain the following:

      [core]
          hooksPath = #{hookspath}

    CAVEATS
  end

  test do
    system "#{bin}/ggh", "--help"
  end
end
