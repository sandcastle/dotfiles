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
* `rm` moves file to the OS X trash

### git

* Opinionated `git log`, `git graph`
* `gcp` for fast `git commit -m ... && git push`
* `git pr <pull-req> [origin]` for fetching pull request branches
* `git cleanup` — clean up merged git branches. Very useful if you’re doing github pull requests in topic branches.
* `git summary` — outputs commit email statistics.
* `git release` — save changes, tag commit. If used on node.js project, also push to npm.
* `git url` - opens GitHub repo for current git repo.
* `git-changelog`, `git-setup` etc.


## Manual changes

- To apply CSS (tab = 2 spaces, font) to GitHub, you will need to copy etc/userChrome.css to firefox profile dir & create subdir "chrome".

## WIP

Look at the following repo's for inspiration:

- [https://github.com/gregf/dotfiles]()
- [https://github.com/thisdarktao/dotfiles]()
- [https://github.com/erichs/dotfiles]()

