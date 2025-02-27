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
    log_error "Unsupported operating system: $OSTYPE"
    exit 1
fi

print_heading "Bootstrap $OS_TYPE..."

# Ask for sudo password upfront
sudo -v
# Keep sudo alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Installation phases
log_info "Initializing"
source "$SCRIPT_DIR/common/init.sh"
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$SCRIPT_DIR/macos/init.sh"
else
    source "$SCRIPT_DIR/linux/init.sh"
fi

log_info "Installing core tools"
source "$SCRIPT_DIR/common/100_core_tools.sh"

log_info "Setting up shell"
source "$SCRIPT_DIR/common/200_shell.sh"

log_info "Setting up system configuration"
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$SCRIPT_DIR/macos/100_system.sh"
    source "$SCRIPT_DIR/macos/120_ui.sh"
    source "$SCRIPT_DIR/macos/130_apps.sh"
    source "$SCRIPT_DIR/macos/140_dev.sh"
else
    source "$SCRIPT_DIR/linux/100_system.sh"
    source "$SCRIPT_DIR/linux/120_ui.sh"
    source "$SCRIPT_DIR/linux/130_apps.sh"
fi

log_info "Running final checks"

# Verify shell setup
if [[ $SHELL != "/bin/zsh" ]]; then
    log_warning "ZSH is not set as default shell"
fi

print_heading "Bootstrap complete!"
exit 0
