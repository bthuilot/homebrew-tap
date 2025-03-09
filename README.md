# Personal Homebrew Tap

## What is Homebrew?

Package manager for macOS (or Linux), see more at https://brew.sh

## What is a Tap?

A third-party (in relation to Homebrew) repository providing installable
packages (formulae) on macOS and Linux.

See more at https://docs.brew.sh/Taps

## How do I install packages from here?

```sh
brew install bthuilot/tap/$NAME
```

You can also only add the tap which makes formulae within it
available in search results (`brew search` output):

```sh
brew tap bthuilot/tap
```

While you may search across taps, it is necessary to always use
fully qualified name (incl. the `bthuilot/tap/` prefix)
when refering to formulae in external taps such as this one
outside of search.

## What packages are available?

### Formulae

| Name                 | Description                                | Link                                                                          |
|----------------------|--------------------------------------------|-------------------------------------------------------------------------------|
| `git-lost-and-found` | Find and name dangling refs in git history | [bthuilot/git-lost-and-found](https://github.com/bthuilot/git-lost-and-found) |
| `ggh`                | Global Git hooks configuration tool        | [bthuilot/ggh](https://github.com/bthuilot/ggh)                               |

