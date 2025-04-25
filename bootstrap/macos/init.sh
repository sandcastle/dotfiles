#!/usr/bin/env bash

log_info "Initializing MacOS"

# Install Homebrew if not installed
if ! command -v brew >/dev/null; then
    log_info "Installing Homebrew..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ "$(uname -m)" == "arm64" ]]; then
        log_info "Configuring Homebrew for Apple Silicon"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    log_success "Homebrew installed successfully"
fi
