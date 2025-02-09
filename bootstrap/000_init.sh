#!/bin/bash
# Initial setup and checks

source "$(dirname "$0")/_funcs.sh"

# Check if running on macOS
if [[ $(uname) != "Darwin" ]]; then
    echo "This script is only for macOS"
    exit 1
fi

# Install Command Line Tools
if ! xcode-select -p &>/dev/null; then
    echo "Installing Command Line Tools..."
    xcode-select --install
    until xcode-select -p &>/dev/null; do
        sleep 5
    done
fi

# Install Homebrew
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi 