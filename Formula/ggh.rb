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
  VERSION = "0.2.2"

  desc "Personalized, global git hooks"
  homepage "https://github.com/bthuilot/ggh"
  url "https://github.com/bthuilot/ggh/archive/refs/tags/v#{VERSION}.tar.gz"
  sha256 "ab3dea8c0327497c66179cb9593fa8ccb1773528de05a32bab5e3dd803b308d6"
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

    ENV["OPAMROOT"] = opamroot
    ENV["OPAMYES"] = "1"

    system "opam", "init", "--no-setup", "--disable-sandboxing", "--bare"
    system "opam", "switch", "create", ".", "--no-install"
    system "opam", "install", ".", "--deps-only", "-y"
    system "opam", "exec", "--", "dune", "build", "--release", "--sandbox=none"

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

    CAVEATS
  end

  test do
    system "#{bin}/ggh", "--help"
  end
end
