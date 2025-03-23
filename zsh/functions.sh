#!/usr/bin/env zsh

# ==================================================================
# Functions
# ==================================================================

# Generate a random password
password() {
  local length=${1:-40}  # Default to 40 if no length specified
  local use_special=${2:-true}  # Default to false if not specified
  
  # Validate length is a positive number
  if ! [[ "$length" =~ ^[0-9]+$ ]] || [ "$length" -lt 1 ]; then
    echo "Error: Length must be a positive number" >&2
    return 1
  fi
  
  if (( $+commands[pwgen] )); then
    # Use pwgen if available (better password generation)
    if [[ "$use_special" == "true" ]]; then
      pwgen -s -c -n -y "$length" 1
    else
      pwgen -s -c -n "$length" 1
    fi
  else
    echo "Error: pwgen not found" >&2
    exit 1
  fi
}

# Open a file or URL in the default browser
b() {
  local url="$1"
  # If it's not a URL (doesn't start with http:// or https:// or file://)
  if [[ ! "$url" =~ ^(https?://|file://) ]]; then
    # If it's a local file that exists, use file:// protocol
    if [[ -f "$url" ]]; then
      url="file://$(realpath "$url")"
    # If it's a local directory that exists, use file:// protocol
    elif [[ -d "$url" ]]; then
      url="file://$(realpath "$url")"
    # Otherwise, assume it's a website and add https://
    else
      url="https://$url"
    fi
  fi
  ${BROWSER:-open} "$url"
}

# Open a file in the default pager
page() { ${PAGER:-moar} "$@" }

# Copy file(s) from remote ssh path to desktop
mecp () {
  scp "$@" ${SSH_CLIENT%% *}:Desktop/;
}


# Show man page in Preview.app.
# $ manp cd
function manp {
  local page
  if (( $# > 0 )); then
    for page in "$@"; do
      man -t "$page" | open -f -a Preview
    done
  else
    print 'What manual page do you want?' >&2
  fi
}

# Show current Finder directory.
function finder {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

# Gets password from OS X Keychain.
# $ get-pass github
function get-pass() {
  keychain="$HOME/Library/Keychains/login.keychain"
  security -q find-generic-password -g -l $@ $keychain 2>&1 |\
    awk -F\" '/password:/ {print $2}';
}

# Opens file in EDITOR.
function edit() {
  local dir=$1
  [[ -z "$dir" ]] && dir='.'
  $EDITOR $dir
}

# Execute commands for each file in current directory.
function each() {
  for dir in *; do
    # echo "${dir}:"
    cd $dir
    $@
    cd ..
  done
}

# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
# # => 9762
function find-exec() {
  if (( $+commands[fd] )); then
    fd --type f --hidden --follow --exclude .git --glob "*${1:-}*" --exec "${2:-file}" '{}'
  else
    find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
  fi
}

# Better find(1)
function ff() {
  if (( $+commands[fd] )); then
    fd --type f --hidden --follow --exclude .git --glob "*${1:-}*"
  else
    find . -iname "*${1:-}*"
  fi
}

# Count code lines in some directory.
# $ loc py js css
# # => Lines of code for .py: 3781
# # => Lines of code for .js: 3354
# # => Lines of code for .css: 2970
# # => Total lines of code: 10105
function loc() {
  local total
  local firstletter
  local ext
  local lines
  total=0
  for ext in $@; do
    firstletter=$(echo $ext | cut -c1-1)
    if [[ firstletter != "." ]]; then
      ext=".$ext"
    fi
    if (( $+commands[bat] )); then
      lines=`find-exec "*$ext" bat --style=plain --color=never | wc -l`
    else
      lines=`find-exec "*$ext" cat | wc -l`
    fi
    lines=${lines// /}
    total=$(($total + $lines))
    echo "Lines of code for ${fg[blue]}$ext${reset_color}: ${fg[green]}$lines${reset_color}"
  done
  echo "${fg[blue]}Total${reset_color} lines of code: ${fg[green]}$total${reset_color}"
}

# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
function ram() {
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    if (( $+commands[procs] )); then
      local mem=$(procs --search "$app" --sort mem --no-header | awk '{sum+=$4} END {printf "%.2f", sum}')
    else
      local sum=0
      for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
        sum=$(($i + $sum))
      done
      local mem=$(echo "scale=2; $sum / 1024.0" | bc)
    fi
    if [[ $mem != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${mem}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

function size() {
  # du -sh "$@" 2>&1 | grep -v '^du:' | sort -nr
  du -shck "$@" | sort -rn | awk '
      function human(x) {
          s="kMGTEPYZ";
          while (x>=1000 && length(s)>1)
              {x/=1024; s=substr(s,2)}
          return int(x+0.5) substr(s,1,1)
      }
      {gsub(/^[0-9]+/, human($1)); print}'
}

# $ git log --no-merges --pretty=format:"%ae" | stats
# # => 514 a@example.com
# # => 200 b@example.com
function stats() {
  sort | uniq -c | sort -r
}

# Shortcut for searching commands history.
# hist git
function hist() {
  if [ -z "$1" ]; then
    echo "Usage: hist <pattern>"
    echo "Example: hist git"
    return 1
  fi
  
  if (( $+commands[rg] )); then
    history 0 | command rg "$@"
  else
    history 0 | grep "$@"
  fi
}

# Monitor IO in real-time (open files etc).
function openfiles() {
  sudo dtrace -n 'syscall::open*:entry { printf("%s %s",execname,copyinstr(arg0)); }'
}

# 4 lulz.
function compute() {
  while true; do head -n 100 /dev/urandom; sleep 0.1; done \
    | hexdump -C | grep "ca fe"
}

# Load 8 cores at once.
function maxcpu() {
  dn=/dev/null
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
  yes > $dn & yes > $dn & yes > $dn & yes > $dn &
}

# retries a command every 1 second
# $ retry ping google.com
function retry() {
  echo Retrying "$@"
  $@
  sleep 1
  retry $@
}

# Open curr dir in preview.app.
function preview() {
  local item=$1
  [[ -z "$item" ]] && item='.'
  open $1 -a 'Preview'
}

# Makes a directory and changes to it.
function mkdcd() {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Displays user owned processes status.
function psu {
  ps -U "${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

# Simple .tar archiving.
function tar_() {
  tar -cvf "$1.tar" "$1"
}

function untar() {
  tar -xvf $1
}

# Create a directory and cd into it
mkcd() {
    mkdir -p "$@" && cd "$_"
}

# Extract any archive
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz)  tar xzf $1 ;;
            *.bz2)     bunzip2 $1 ;;
            *.rar)     unrar x $1 ;;
            *.gz)      gunzip $1 ;;
            *.tar)     tar xf $1 ;;
            *.tbz2)    tar xjf $1 ;;
            *.tgz)     tar xzf $1 ;;
            *.zip)     unzip $1 ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1 ;;
            *)         echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Git commit browser using fzf
fzf-git-log() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Search directory contents with fzf
fzf-find() {
    local file
    file=$(fd --type f --hidden --follow --exclude .git | fzf \
        --preview 'bat --style=numbers --color=always {}')
    if [[ -n $file ]]; then
        $EDITOR "$file"
    fi
}

# Add a new function that summaires all aliases in aliases.sh
function aliases() {
  cat "${DOTFILES:-$HOME/Developer/dotfiles}/zsh/aliases.sh" | grep "^alias" | sort | bat --color=always --paging=always
}
