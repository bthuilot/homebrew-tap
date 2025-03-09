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
  VERSION = '0.1.2'

  desc 'Personalized, global git hooks'
  homepage 'https://github.com/bthuilot/ggh'
  version VERSION
  license 'GPL-3.0-or-later'
  url "https://github.com/bthuilot/ggh/archive/refs/tags/v#{VERSION}.tar.gz"
  sha256 '4372ecd60d9aaa3fde70d6cd53b9885911857adc47315714c1b5b280623729c4'

  depends_on 'opam' => :build
  depends_on 'git'

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
    opamroot = buildpath / '.opam'

    ENV['OPAMROOT'] = opamroot
    ENV['OPAMYES'] = '1'

    system 'opam', 'init', '--no-setup', '--disable-sandboxing'
    system 'opam', 'update'
    system 'opam', 'exec', '--', 'opam', 'install', '.', '--deps-only', '-y'
    system 'opam', 'exec', '--', 'dune', 'build'

    bin.install buildpath / '_build/default/bin/ggh/main.exe' => 'ggh'

    ALL_HOOKS.each do |hook|
      bin.install_symlink bin / 'ggh' => "hooks/#{hook}"
    end
  end

  def post_install
    system 'opam', 'exec', '--', 'dune', 'clean'
  end

  def caveats
    hooks_dir = bin / 'hooks'
    <<~CAVEATS
      WARNING: ggh is not currently configured,
      please run `GGH_HOOKS_DIR=#{hooks_dir} ggh configure` to set ggh as your global hooks
    CAVEATS
  end

  test do
    system "#{bin}/ggh --help"
  end
end
