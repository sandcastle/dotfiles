#!/usr/bin/env bash

log_info "Initializing MacOS"

# Source common functions
source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

# Install Homebrew if not installed
if ! command -v brew >/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ "$(uname -m)" == "arm64" ]]; then
        log_info "Configuring Homebrew for Apple Silicon"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    log_success "Homebrew installed successfully"
fi

# Update Homebrew
log_info "Updating Homebrew"
brew update
log_success "Homebrew updated successfully"
