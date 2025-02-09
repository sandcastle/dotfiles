#!/usr/bin/env zsh

# ==================================================================
# Aliases
# ==================================================================

# ------------------------------ DEV -------------------------------

# Common project scripts - used on all project irrespective of lang
alias sc='sh script/clean'   # clean the application
alias si='sh script/install' # install packages/dependencies
alias su='sh script/update'  # update packages/dependencies
alias sl='sh script/lint'    # lint the application
alias st='sh script/test'    # test the application
alias sb='sh script/build'   # build the application
alias ss='sh script/start'   # run the application
alias sf='sh script/format'  # format the code
alias sp='sh script/package' # package the application
alias sd='sh script/deploy'  # deploy the application
alias s!='echo "s  = script shortcut help\nsc = sh script/clean\nsf = sh script/format\nsl = sh script/lint\nst = sh script/test\nsb = sh script/build\nss = sh script/server\nsi = sh script/install\nsu = sh script/update\nsp = sh script/package\nsd = sh script/deploy"'

# yarn shortcuts
alias y='yarn'
alias yc='yarn clean'
alias yi='yarn init'
alias yl='yarn lint --fix'
alias yu='yarn install'
alias yb='yarn build'
alias yt='yarn test'
alias ys='yarn start'
alias yyb='yarn && yarn build'
alias y!='echo "y  = yarn shortcut help\nyc = yarn clean\nyl = yarn lint --fix\nyi = yarn init\nyb = yarn build\nyt = yarn test\nys = yarn start"'

# dotnet shortcuts
alias d='dotnet --info'
alias dr='dotnet restore'
alias dc='dotnet clean'
alias dn='dotnet new'
alias db='dotnet build'
alias dt='dotnet test'
alias ds='dotnet run'
alias du='dotnet update'

# Lines of Code counter
alias lines='git ls-files | xargs cloc'

# Pretty print json
alias json='python3 -m json.tool'

# Deploy
alias kamal='docker run -it --rm -v "${PWD}:/workdir" -v "/run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock" -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/basecamp/kamal:latest'

# --------------------------- NETWORK ------------------------------

# Serves a directory via HTTP
alias http-serve='python3 -m http.server'

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

alias http-time='curl -o /dev/null -s -w "Establish Connection: %{time_connect}s\nTTFB: %{time_starttransfer}s\nTotal: %{time_total}s\n"'

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
alias clipc='pbcopy'
alias clipp='pbpaste'

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

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Modern replacements
alias ls='exa --group-directories-first'
alias ll='exa -l --group-directories-first'
alias la='exa -la --group-directories-first'
alias cat='bat'
alias find='fd'
alias grep='rg'

# Git aliases
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

# Development
alias c='code .'
alias python='python3'
alias pip='pip3'

# System
alias reload='source ~/.zshrc'
alias path='echo $PATH | tr ":" "\n"'
alias ports='lsof -i -P -n | grep LISTEN'
