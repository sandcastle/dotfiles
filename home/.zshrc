#!/bin/zsh

# Performance profiling (uncomment to debug slow startup)
# zmodload zsh/zprof

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

# Load completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion

# Initialize modern tools
eval "$(zoxide init zsh)"  # Better directory navigation
eval "$(starship init zsh)" # Modern prompt

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Performance improvements
# Skip compinit on every shell load
skip_global_compinit=1

# Load essential environment variables first
export DOT_FILES="$HOME/Developer/dotfiles"
export PATH="$HOME/.fastlane/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
eval $(/usr/libexec/path_helper -s)

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# Plugin configuration - Optimized based on your tools and usage
plugins=(
    git                   # Git integration and aliases
    docker                # Docker commands and completion
    node                  # Node.js and npm/yarn commands
    golang                # Go development
    kubectl               # Kubernetes commands
    helm                  # Helm commands
    terraform             # Terraform commands
    aws                   # AWS CLI commands
    gcloud                # Google Cloud commands
    z                     # Quick directory navigation
    macos                 # Replaces most of your osx.sh aliases
    dotnet                # .NET Core commands
    yarn                  # Yarn package manager
    brew                  # Homebrew commands
    httpie                # HTTP client
)

# Performance optimization settings
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true
DISABLE_UNTRACKED_FILES_DIRTY=true
HIST_STAMPS="yyyy-mm-dd"

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Source additional configurations
source "$DOT_FILES/zsh/aliases.sh"
source "$DOT_FILES/zsh/functions.sh"
source "$DOT_FILES/zsh/tools.sh"
source "$DOT_FILES/zsh/cloud.sh"
source "$DOT_FILES/zsh/git.sh"
source "$DOT_FILES/zsh/osx.sh"

# Language environments
source "$DOT_FILES/lang/dotnet/env.sh"
source "$DOT_FILES/lang/js/env.sh"
source "$DOT_FILES/lang/ruby/env.sh"

# iTerm2 integration (if exists)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Local environment (if exists)
[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Optimize command completion system
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
    compinit
else
    compinit -C
fi
