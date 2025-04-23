#!/usr/bin/env bash

# Performance profiling (uncomment to debug slow startup)
# zmodload zsh/zprof

# Get the actual dotfiles directory path, handling both direct and symlinked cases
export DOTFILES="$(dirname "$(dirname "$(readlink -f "${(%):-%x}")")")"

# ZSH Options
setopt AUTO_CD              # cd by typing directory name
setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode
setopt EXTENDED_GLOB       # Extended globbing
setopt NO_CASE_GLOB       # Case insensitive globbing
setopt NUMERIC_GLOB_SORT  # Sort filenames numerically
setopt EXTENDED_HISTORY    # Write the history file in the ':start:elapsed;command' format
setopt SHARE_HISTORY       # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS   # Do not record an event that was just recorded again
setopt HIST_FIND_NO_DUPS  # Do not display a previously found event
setopt HIST_IGNORE_SPACE  # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS  # Do not write a duplicate event to the history file

# Environment variables
export EDITOR='nvim'
export KUBE_EDITOR='nvim'
export VISUAL='code'
export PAGER='moar'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# FZF configuration
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh

# Performance improvements
# Skip compinit on every shell load
skip_global_compinit=1

  # macOS specific path helper
if [[ "$OSTYPE" == "darwin"* ]]; then
  eval $(/usr/libexec/path_helper -s)
fi

# Completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# Performance optimization settings
HIST_STAMPS="yyyy-mm-dd"

# Autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Syntax Highlighting Colors
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Customize colors
typeset -A ZSH_HIGHLIGHT_STYLES

# Paste warning (optional)
ZSH_HIGHLIGHT_STYLES[paste]='fg=black,bold,bg=yellow'

# Highlight dangerous commands with red background and white text
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
# Base styles
ZSH_HIGHLIGHT_STYLES[default]=none                   # Default text style
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold      # Unknown commands or tokens
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow        # Shell reserved words (if, for, while, etc.)
# Command styles
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold            # Command aliases
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=cyan,bold     # Suffix aliases
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold          # Shell builtin commands
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold         # Shell functions
ZSH_HIGHLIGHT_STYLES[command]=fg=cyan,bold          # Regular commands
ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,bold,underline  # Commands with precommand modifiers
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold # Command separators (;, &&, ||)
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=cyan,bold   # Commands that are hashed (cached)
# Path and globbing styles
ZSH_HIGHLIGHT_STYLES[path]=fg=green,underline       # File paths
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=green,underline # Path prefixes
ZSH_HIGHLIGHT_STYLES[globbing]=fg=magenta,bold      # Globbing patterns (*, ?, etc.)
# Option styles
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=yellow    # Single-hyphen options (-l)
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=yellow    # Double-hyphen options (--long)
# Argument styles
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=magenta,bold          # Back-quoted arguments (`command`)
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=green,bold          # Single-quoted arguments ('text')
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=green,bold          # Double-quoted arguments ("text")
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=green,bold          # Dollar-quoted arguments ($'text')
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold # Dollar-double-quoted arguments ($"text")
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold   # Back-double-quoted arguments (`"text"`)
ZSH_HIGHLIGHT_STYLES[comment]='fg=grey'      # Comments
ZSH_HIGHLIGHT_STYLES[quoted]='fg=yellow'     # Quoted text

# Assignment style
ZSH_HIGHLIGHT_STYLES[assign]=fg=blue,bold           # Variable assignments (VAR=value)

# Source additional configurations
. "$DOTFILES/zsh/aliases.sh"
. "$DOTFILES/zsh/functions.sh"
. "$DOTFILES/zsh/tools.sh"
. "$DOTFILES/zsh/cloud.sh"
. "$DOTFILES/zsh/git.sh"
. "$DOTFILES/zsh/osx.sh"
. "$DOTFILES/zsh/mcp.sh"

# Language environments
. "$DOTFILES/lang/dotnet/env.sh"
. "$DOTFILES/lang/js/env.sh"
. "$DOTFILES/lang/ruby/env.sh"
. "$DOTFILES/lang/go/env.sh"

# iTerm2 integration (if exists)
[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && . "${HOME}/.iterm2_shell_integration.zsh"

# Local environment (if exists)
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Load dotfile completions
fpath=("$DOTFILES/zsh/completions" $fpath)

# Optimize command completion system
autoload -Uz compinit
# Cross-platform check for zcompdump modification time
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS version
    if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
        compinit -u
    else
        compinit -u -C
    fi
else
    # Linux version - simpler approach that checks if dump file is older than 24 hours
    if [[ -f ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
        compinit -u
    else
        compinit -u -C
    fi
fi

# Install zi if not already installed
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

# Load zi
. "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Load zi annexes and meta-plugins
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes

# Configure OMZP and OMZL shorthands
zi light z-shell/z-a-patch-dl

# Core zsh plugins with optimized loading
zi wait lucid atload"zicompinit; zicdreplay" blockf for \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-history-substring-search
  # zsh-fast-syntax-highlighting

# Load git plugin and setup aliases
# zi snippet OMZL::git.zsh
# zi snippet OMZP::git

# Theme appearance settings
# zi snippet OMZL::theme-and-appearance.zsh

# # Prompt setup
# zi snippet OMZL::prompt_info_functions.zsh
# setopt prompt_subst

# # Load the robbyrussell theme directly
# zi snippet OMZT::robbyrussell

# Load cloud/container plugins
# zi wait lucid as"completion" for \
#   https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker \
#   https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose

# Tool-specific plugins with conditional loading
zi wait lucid for \
  has"aws" \
    OMZP::aws \
  has"brew" \
    OMZP::brew \
  has"kubectl" \
    OMZP::kubectl \
  has"terraform" \
    OMZP::terraform \
  has"go" \
    OMZP::golang \
  has"node" \
    OMZP::node \
  has"yarn" \
    OMZP::yarn \
  has"z" \
    OMZP::z \
  has'pip' \
    OMZP::pip \
  has"python" \
    OMZP::python
#   has"zoxide" \
#     OMZP::zoxide

# Configure keybindings for history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Initialize modern tools
eval "$(starship init zsh)" # Modern prompt
