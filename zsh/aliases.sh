#!/usr/bin/env bash

# ==================================================================
# Aliases
# ==================================================================

# Commonly used directories.
alias dot='cd $DOTFILES_HOME'
alias dev='cd $DEV_HOME'
alias me='cd $DEV_ME'
alias tmp='cd $DEV_TMP'
alias work='cd $DEV_WORK'
alias dotfiles-update='curl -s "https://raw.githubusercontent.com/sandcastle/dotfiles/master/install.sh?t=$(date +%s%N)" | bash'

# Remove all items safely, to Trash (`brew install trash`).
alias rm='trash'

# Case-insensitive pgrep that outputs full path.
alias pgrep='pgrep -fli'

# Shortcut for nvim
alias n='nvim'

# Get my public IP address
alias ip='curl -s ifconfig.me'

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
alias yl='yarn lint'
alias ylf='yarn lint -- --fix'
alias yu='yarn install'
alias yb='yarn build'
alias yt='yarn test'
alias ys='yarn start'
alias yyb='yarn && yarn build'
alias y!='echo "y  = yarn\nyc = yarn clean\nyl = yarn lint --fix\nyi = yarn init\nyb = yarn build\nyt = yarn test\nys = yarn start"'

# pnpm shortcuts
alias p='pnpm'
alias pa='pnpm add'
alias pi='pnpm install'
alias pu='pnpm update -i'
alias puu='pnpm up -i --latest --recursive'
alias pd='pnpm dev'
alias pr='pnpm remove'
alias px='pnpm exec'
alias pb='pnpm build'
alias pt='pnpm test'
alias ps='pnpm start'
alias pl='pnpm lint'
alias plf='pnpm lint --fix'
alias pib='pnpm install && pnpm build'
alias pc='pnpm clean'
alias p!='echo "pi = pnpm install\npr = pnpm remove\npx = pnpm exec\npb = pnpm build\npt = pnpm test\nps = pnpm start\npl = pnpm lint\nplf = pnpm lint --fix\npc = pnpm clean\nppb = pnpm install && pnpm build"'

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

alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias po='popd'
alias pu='pushd'
alias type='type -a'

# list
# These will only be used if the eza aliases aren't available
if ! (( $+commands[eza] )); then
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
fi

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
if (( $+commands[duf] )); then
  # duf: Better disk usage/free utility with colorful graphs
  alias df='duf'
else
  alias df='df -kh'
fi

if (( $+commands[dust] )); then
  # dust: More intuitive version of du with colored output
  alias du='dust'
else
  alias du='du -kh'
fi

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
# Use conditional checks to ensure commands exist before aliasing them
if (( $+commands[eza] )); then
  # eza: Modern, colorized ls replacement with better defaults
  alias ls='eza --group-directories-first'
  alias ll='eza -l --group-directories-first'
  alias la='eza -la --group-directories-first'
  alias lt='eza -la --group-directories-first --sort=modified'
  alias lz='eza -la --group-directories-first --sort=size'
  alias lg='eza -la --group-directories-first --git'
  alias tree='eza --tree'
fi

# Helper function to detect if running in VSCode or Cursor
is_agent_context() {
  # Multiple detection methods for Cursor context
  # 1. Check if its vscode or cursor (both have the same TERM_PROGRAM)
  # 2. Check if this is being executed from a non-interactive shell (common in agents)
  if [[ "$TERM_PROGRAM" == "vscode" ]] &&
     [[ ! -o interactive ]]; then
    return 0  # true in shell logic
  else
    return 1  # false in shell logic
  fi
}

if (( $+commands[bat] )); then
  # bat: cat clone with syntax highlighting and Git integration
  # Smart wrapper that disables paging when called from VSCode/Cursor
  bat_wrapper() {
    if is_agent_context; then
      # Dont use paging or style this can break AI agents
      bat --paging=never --style=plain "$@"
    else
      bat "$@"  # Default behavior with auto paging, which is interactive
    fi
  }
  alias cat='bat_wrapper'
fi

if (( $+commands[fd] )); then
  # fd: Faster and friendlier alternative to the find command
  alias find='fd'
fi

if (( $+commands[rg] )); then
  # ripgrep: Fast line-oriented search tool (grep replacement)
  alias grep='rg'
fi

if (( $+commands[procs] )); then
  # procs: Modern replacement for ps with additional features
  alias ps='procs'
fi

if (( $+commands[sd] )); then
  # sd: Intuitive find & replace CLI (sed alternative)
  alias sed='sd'
fi

if (( $+commands[gping] )); then
  # gping: Ping with a graphical display
  alias ping='gping'
fi

if (( $+commands[tealdeer] )); then
  # tealdeer: Fast tldr client (simplified, example-based man pages)
  alias tldr='tealdeer'
elif (( $+commands[tldr] )); then
  # Some systems might have the tldr package instead
  alias tldr='tldr'
fi

if (( $+commands[xh] )); then
  # xh: Friendly HTTP tool, alternative to curl/httpie
  alias https='xh'
fi

if (( $+commands[hyperfine] )); then
  # hyperfine: Command-line benchmarking tool
  alias bench='hyperfine'
fi

if (( $+commands[delta] )); then
  # delta: Syntax-highlighting pager for git and diff output
  alias diff='delta'
fi

if (( $+commands[choose] )); then
  # choose: cut/awk alternative with a more intuitive interface
  alias cut='choose'
fi

# Bottom (better top) aliases
if (( $+commands[bottom] )); then
  # bottom: Graphical system/process monitor, alternative to top/htop
  alias btm='bottom'
  alias cpu='bottom --basic --proc-tree --process-command --tree --config_type memory'
  alias mem='bottom --basic --proc-tree --process-command --tree --config_type cpu'
fi

# Git aliases
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline'
alias glo='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gb='git branch'

# Add git config to use delta if available
# Move the git config commands to a function to avoid execution on sourcing
if (( $+commands[delta] )); then
  setup_git_delta() {
    git config --global core.pager "delta"
    git config --global interactive.diffFilter "delta --color-only"
  }
  # User can explicitly call this function when needed
  alias setup-git-delta='setup_git_delta'
fi

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
