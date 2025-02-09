#!/bin/bash

echo "Installing macOS-specific core tools..."

# Source common functions
source "$(dirname "$0")/../_funcs.sh"

# Install macOS-specific core applications
brew install --cask \
    iterm2 \
    visual-studio-code

core_tools=(
    "iterm2"
    "visual-studio-code"
)

# Install all tool categories
install_packages "${core_tools[@]}"
