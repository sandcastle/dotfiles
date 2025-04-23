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

# Initialize modern tools
eval "$(starship init zsh)" # Modern prompt

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Performance improvements
# Skip compinit on every shell load
skip_global_compinit=1

# Load essential environment variables first
export PATH="$HOME/.fastlane/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
eval $(/usr/libexec/path_helper -s)

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# Completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# Plugin configuration - Optimized based on your tools and usage
plugins=(
    aws                          # AWS CLI commands
    brew                         # Homebrew commands
    docker                       # Docker commands and completion
    doctl                        # Digital Ocean CLI
    dotnet                       # .NET Core commands
    emoji                        # Emoji completion
    gcloud                       # Google Cloud commands
    git                          # Git integration and aliases
    gh                           # GitHub CLI
    golang                       # Go development
    helm                         # Helm commands
    httpie                       # HTTP client
    kubectl                      # Kubernetes commands
    macos                        # Replaces most of your osx.sh aliases
    node                         # Node.js and npm/yarn commands
    terraform                    # Terraform commands
    vscode                       # VSCode commands
    yarn                         # Yarn package manager
    z                            # Quick directory navigation
    zoxide                       # Better directory navigation
)

# Performance optimization settings
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true
DISABLE_UNTRACKED_FILES_DIRTY=true
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

# Source Oh My Zsh
. $ZSH/oh-my-zsh.sh

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

# Load brew completions and plugins
if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)
    # Mark as safe paths
    ZSH_DISABLE_COMPFIX=true
    fpath=(
        "$BREW_PREFIX/share/zsh-autosuggestions"
        "$BREW_PREFIX/share/zsh-completions"
        "$BREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting"
        # "$BREW_PREFIX/share/zsh-syntax-highlighting"
        $fpath
    )
    # Load plugins
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source "$BREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
    # source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Load dotfile completions
fpath=("$DOTFILES/zsh/completions" $fpath)

# Optimize command completion system
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
    compinit -u
else
    compinit -u -C
fi
