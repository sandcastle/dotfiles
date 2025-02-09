#!/bin/bash

# Exit on error
set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions and utilities
source "$SCRIPT_DIR/_funcs.sh"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

print_heading "Starting bootstrap for $OS_TYPE"

# Ask for sudo password upfront
sudo -v
# Keep sudo alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Installation phases
echo "Initializing"
source "$SCRIPT_DIR/common/init.sh"
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$SCRIPT_DIR/macos/init.sh"
else
    source "$SCRIPT_DIR/linux/init.sh"
fi

echo "Installing core tools"
source "$SCRIPT_DIR/common/100_core_tools.sh"
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$SCRIPT_DIR/macos/100_core_tools.sh"
else
    source "$SCRIPT_DIR/linux/100_core_tools.sh"
fi

echo "Setting up shell"
source "$SCRIPT_DIR/common/200_shell.sh"
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$SCRIPT_DIR/macos/200_shell.sh"
else
    source "$SCRIPT_DIR/linux/200_shell.sh"
fi

echo "Setting up system configuration"
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$SCRIPT_DIR/macos/610_system.sh"
    source "$SCRIPT_DIR/macos/620_ui.sh"
    source "$SCRIPT_DIR/macos/630_apps.sh"
    source "$SCRIPT_DIR/macos/640_dev.sh"
else
    source "$SCRIPT_DIR/linux/610_system.sh"
    source "$SCRIPT_DIR/linux/620_ui.sh"
    source "$SCRIPT_DIR/linux/630_apps.sh"
    source "$SCRIPT_DIR/linux/640_dev.sh"
fi

echo "Setting up common tools and configurations"
source "$SCRIPT_DIR/common/tools.sh"

echo "Running final checks"
# Verify shell setup
if [[ $SHELL != "/bin/zsh" ]]; then
    echo "Warning: ZSH is not set as default shell"
fi

print_heading "Bootstrap complete!"
exit 0
