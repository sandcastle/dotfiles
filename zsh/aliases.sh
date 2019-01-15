#!/usr/bin/env zsh

# ==================================================================
# Aliases
# ==================================================================

# ------------------------------ DEV -------------------------------

# Common project scripts - used on all project irrespective of lang
alias sc='sh script/clean'  # clean the application
alias sf='sh script/format'  # format the code
alias sl='sh script/lint'   # lint the application
alias st='sh script/test'   # test the application
alias sb='sh script/build'  # build the application
alias ss='sh script/server' # run the server application
alias si='sh script/install' # install packages/dependencies
alias su='sh script/update' # update packages/dependencies

# azure
alias az='$HOME/bin/az'

# kubernetes
alias kube='kubectl'
alias kubeproxy='kube proxy &'

# vs code
alias code='code-insiders'

# git tower
alias tower=gittower

# Lines of Code counter
alias lines='git ls-files | xargs cloc'

# Pretty print json
alias json='python -m json.tool'

# --------------------------- NETWORK ------------------------------

# Serves a directory via HTTP
alias http-serve='python -m SimpleHTTPServer'

# Disable certificate check for wget.
alias wget='wget --no-check-certificate'

# Checks whether connection is up.
alias net="ping ya.ru | grep -E --only-match --color=never '[0-9\.]+ ms'"

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

# Download (Show progress)
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

# ----------------------------- SHELL ------------------------------

# Simple clear command
alias cl='clear'
alias cls='clear'

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Define general aliases.
alias _='sudo'
alias b='${(z)BROWSER}'
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'

# list
alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.

# ------------------------------ OSX -------------------------------

# Mac OS X Everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
else
  alias o='xdg-open'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

# Clipboard
alias pbc='pbcopy'
alias pbp='pbpaste'

# Disk Usage (Human Readable)
alias df='df -kh'
alias du='du -kh'

# Process Usage (Prefer htop)
if (( $+commands[htop] )); then
  alias top=htop
  alias topc='htop --sort-key PERCENT_CPU'
  alias topm='htop --sort-key VSIZE'
else
  alias topc='top -o cpu'
  alias topm='top -o vsize'
fi
