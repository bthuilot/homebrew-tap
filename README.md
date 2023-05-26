# Personal Homebrew Tap

## What is Homebrew?

Package manager for macOS (or Linux), see more at https://brew.sh

## What is a Tap?

A third-party (in relation to Homebrew) repository providing installable
packages (formulae) on macOS and Linux.

See more at https://docs.brew.sh/Taps

## How do I install packages from here?

```sh
brew install bthuilot/tap/name
```

You can also only add the tap which makes formulae within it
available in search results (`brew search` output):

```sh
brew tap bthuilot/tap
```

Note: to clone the tap via SSH you will need to use:

```sh
brew tap bthuilot/tap https://github.com/bthuilot/homebrew-tap
```

While you may search across taps, it is necessary to always use
fully qualified name (incl. the `bthuilot/tap/` prefix)
when refering to formulae in external taps such as this one
outside of search.

## What packages are available?

With the following commands, you can install the latest generally available (GA) version of each product:
```sh
# Formulae
brew install bthuilot/tap/dockerleaks

# Casks
# none
```
