#!/bin/bash

echo "Installing Linux-specific core tools..."

# Source common functions
source "$(dirname "$0")/../_funcs.sh"

# Install Linux-specific packages
if command -v apt-get >/dev/null; then
    sudo apt-get install -y \
        build-essential \
        vim \
        zsh
elif command -v dnf >/dev/null; then
    sudo dnf install -y \
        @development-tools \
        vim \
        zsh
elif command -v pacman >/dev/null; then
    sudo pacman -S --noconfirm \
        base-devel \
        vim \
        zsh
fi
