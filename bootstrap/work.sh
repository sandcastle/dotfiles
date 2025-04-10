#!/usr/bin/env sh

set -e
cd "$(dirname "$0")/.."

source "$(dirname "$0")/_funcs.sh"

install_brew() {
    local package=$1
    
    # First check if it exists anywhere on the system
    if program_exists "$package"; then
        echo "Note: $package appears to be installed outside of brew"
        return 0
    fi
    
    # Try to install and handle the "already exists" error
    if brew search --casks "^${package}$" &>/dev/null; then
        if ! brew list --cask "$package" &>/dev/null; then
            echo "Installing cask $package..."
            if brew install --cask "$package" 2>&1 | grep -q "already .* at .*\.app"; then
                echo "Note: $package is already installed outside of brew"
                return 0
            fi
        else
            echo "Cask $package is already installed"
        fi
    elif brew search --formula "^${package}$" &>/dev/null; then
        if ! brew list --formula "$package" &>/dev/null; then
            echo "Installing formula $package..."
            brew install "$package"
        else
            echo "Formula $package is already installed"
        fi
    else
        echo "Error: $package not found in brew"
        return 1
    fi
}

install_brew "1password"
install_brew "zoom"
install_brew "slack"
