#!/usr/bin/env sh

# ==================================================================
# Git
# ==================================================================

# Aliases
alias g='git'
alias ga='git add'
alias gd='git add'
alias gr='git reset'
alias grh='git reset --hard'

alias gf='git fetch'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'

alias gs='git status --short'
alias gdiff='git diff'
alias gdiffs='git diff --staged'
alias gdisc='git discard'

alias gcl='git clone'
alias gch='git checkout'
alias gbr='git branch'
alias gbrd='git branch -D'
alias gl='git log --no-merges'

function gc() {
  args=$@
  git commit -m "$args"
}

function gca() {
  args=$@
  git commit --amend -m "$args"
}

alias gp='git push'

function gcp() {
  args=$@
  git commit -am "$args" && git push
}


# Git log colors.
zstyle -s ':prezto:module:git:log:medium' format '_git_log_medium_format' \
  || _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
zstyle -s ':prezto:module:git:log:oneline' format '_git_log_oneline_format' \
  || _git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
zstyle -s ':prezto:module:git:log:brief' format '_git_log_brief_format' \
  || _git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'

# Git status colors
zstyle -s ':prezto:module:git:status:ignore' submodules '_git_status_ignore_submodules' \
  || _git_status_ignore_submodules='none'
