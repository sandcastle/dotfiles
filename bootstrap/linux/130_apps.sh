#!/usr/bin/env bash

# Source common functions
source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

log_h1 "Installing applications"

log_info "Installing core applications"

# Install Linux-specific packages based on package manager
if command -v apt-get >/dev/null; then
    log_info "Using apt package manager"
    sudo apt-get install -y \
        build-essential \
        neovim \
        vim \
        zsh
elif command -v dnf >/dev/null; then
    log_info "Using dnf package manager"
    sudo dnf install -y \
        @development-tools \
        neovim \
        vim \
        zsh
elif command -v pacman >/dev/null; then
    log_info "Using pacman package manager"
    sudo pacman -S --noconfirm \
        base-devel \
        neovim \
        vim \
        zsh
fi

log_success "Application configuration complete"
