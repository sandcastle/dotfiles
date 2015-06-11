# Dotfiles
My dot files and OSX setup.

Heavily inspired by Paul Miller's excellent [dotfiles](https://github.com/paulmillr/dotfiles) repo.


## Install

Install just the dotfiles:

```bash
curl --silent https://raw.githubusercontent.com/sandcastle/dotfiles/master/install.sh | sh
```

Bootstrap a new OSX system:

```bash
curl --silent https://raw.githubusercontent.com/sandcastle/dotfiles/master/bootstrap-osx.sh | sh
```


## Features

### zsh

* Auto-completion
* Syntax highlighting
* Automatic setting up of terminal tab / window title to current dir
* `rm` moves file to the OS X trash
* A bunch of useful functions:
    * `extract archive.tar.bz` — unpack any archive (supports many extensions)
    * `ram safari` — show app RAM usage
    * `openfiles` — real-time disk usage monitoring with `dtrace`.
    * `loc py coffee js html css` — count lines of code in current dir in a colourful way.
    * `ff file-name-or-pattern` - fast recursive search for a file name in directories.
    * `curl http://site/v1/api.json | json` - pretty-print JSON
    * `aes-enc`, `aes-dec` - safely encrypt files.

### git

* Opinionated `git log`, `git graph`
* `gcp` for fast `git commit -m ... && git push`
* `git pr <pull-req> [origin]` for fetching pull request branches
* `git cleanup` — clean up merged git branches. Very useful if you’re doing github pull requests in topic branches.
* `git summary` — outputs commit email statistics.
* `git release` — save changes, tag commit. If used on node.js project, also push to npm.
* `git url` - opens GitHub repo for current git repo.
* `git-changelog`, `git-setup` etc.


## Structure

* `bin` — files that are symlinked to any directory with binaries in `$PATH`
* `etc` — various stuff like osx text substitutions / hosts backup
* `git-extras` — useful git functions, defined in `home/gitconfig`
* `home` — files that are symlinked to `$HOME` directory
* `terminal` — terminal theme & prompt


## WIP

Look at the following repo's for inspiration:

- [](https://github.com/gregf/dotfiles)
- [](https://github.com/thisdarktao/dotfiles)
- [](https://github.com/erichs/dotfiles)

