#!/usr/bin/env sh

log_info "Initializing"

# Source common functions
source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

# Set up initial environment variables
export DOTFILES_REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Create necessary directories
log_info "Creating required directories"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Developer"

# Basic git configuration if not already set
if [[ -z "$(git config --global user.name)" ]]; then
    log_info "Setting git user.name"
    git config --global user.name "$GIT_NAME"
fi

if [[ -z "$(git config --global user.email)" ]]; then
    log_info "Setting git user.email"
    git config --global user.email "$GIT_EMAIL"
fi
