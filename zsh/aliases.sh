#!/usr/bin/env zsh

# ==================================================================
# Aliases
# ==================================================================

# Simple clear command.
alias cl='clear'

# Disable sertificate check for wget.
alias wget='wget --no-check-certificate'

# JSHint short-cut.
alias lint=jshint

# Some OS X-only stuff.
if [[ "$OSTYPE" == darwin* ]]; then

  # Short-cuts for copy-paste.
  alias c='pbcopy'
  alias p='pbpaste'

  # Remove all items safely, to Trash (`brew install trash`).
  alias rm='trash'

  # Case-insensitive pgrep that outputs full path.
  alias pgrep='pgrep -fli'

  # Lock current session and proceed to the login screen.
  alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

  # Sniff network info.
  alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

  # Process grep should output full paths to binaries.
  alias pgrep='pgrep -fli'

else

  # Process grep should output full paths to binaries.
  alias pgrep='pgrep -fl'

fi

# Git short-cuts.
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

alias gcl='git clone'
alias gch='git checkout'
alias gbr='git branch'
alias gbrd='git branch -D'
alias gl='git log --no-merges'


# Dev short-cuts.

# Package managers.
alias bi='bower install'
alias bis='bower install --save'
alias ni='npm install'
alias nis='npm install --save'
alias nibi='npm install && bower install'
alias nibir='rm -rf {bower_components,node_modules} && npm install && bower install'
alias ns='npm search'

alias jk='jekyll serve --watch' # lol jk
alias serve='python -m SimpleHTTPServer'

# Ruby.
alias bx='bundle exec'
alias bex='bundle exec'

# Nginx short-cuts.
alias ngup='sudo nginx'
alias ngdown='sudo nginx -s stop'
alias ngre='sudo nginx -s stop && sudo nginx'
alias nglog='tail -f /usr/local/var/log/nginx/access.log'
alias ngerr='tail -f /usr/local/var/log/nginx/error.log'

# Checks whether connection is up.
alias net="ping ya.ru | grep -E --only-match --color=never '[0-9\.]+ ms'"

# Pretty print json
alias json='python -m json.tool'

# Burl: better curl shortcuts (https://github.com/visionmedia/burl).
if (( $+commands[burl] )); then
  alias GET='burl GET'
  alias HEAD='burl -I'
  alias POST='burl POST'
  alias PUT='burl PUT'
  alias PATCH='burl PATCH'
  alias DELETE='burl DELETE'
  alias OPTIONS='burl OPTIONS'
fi

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
