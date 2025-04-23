#!/usr/bin/env bash

( set -o pipefail; ) 2>/dev/null || true
set -e

# Get script directory in a POSIX-compatible way
if [ -n "$BASH_VERSION" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
fi

. "$SCRIPT_DIR/_funcs.sh"

# Enhanced error handler
error_handler() {
    local line="$1"
    local command="$2"
    local code="${3:-1}"
    local script="$(basename "$0")"
    
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Error in $script at line $line"
    echo "Command: $command"
    echo "Exit code: $code"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    exit "$code"
}

# Set up traps for different signals
if [ -n "$BASH_VERSION" ]; then
    trap 'error_handler $LINENO "$BASH_COMMAND" $?' ERR
else
    trap 'error_handler $LINENO "command" $?' ERR
fi

# Handle interrupts and termination
trap 'echo; echo "Goodbye, script interrupted."; exit 130' INT

# Source common functions and utilities
. "$SCRIPT_DIR/_funcs.sh"

# Detect OS
case "$OSTYPE" in
    darwin*)
        OS_TYPE="macos"
        ;;
    linux-gnu*)
        OS_TYPE="linux"
        ;;
    *)
        log_error "Unsupported operating system: $OSTYPE"
        exit 1
        ;;
esac

log_h1 "Bootstrap $OS_TYPE"

# Check if sudo requires a password or can run without it
if ! sudo -n true 2>/dev/null; then
    log_info "Requesting sudo access"
    sudo -v
    # Keep sudo alive
    (while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null) &
    SUDO_PID=$!
    # Make sure to kill the sudo refresh process on exit
    trap 'kill $SUDO_PID 2>/dev/null || true' EXIT
fi

# Installation phases
. "$SCRIPT_DIR/common/init.sh"
if [ "$OS_TYPE" = "macos" ]; then
    . "$SCRIPT_DIR/macos/init.sh"
else
    . "$SCRIPT_DIR/linux/init.sh"
fi

. "$SCRIPT_DIR/common/100_shell.sh"
. "$SCRIPT_DIR/common/101_apps.sh"

if [ "$OS_TYPE" = "macos" ]; then
    log_info "Setting up Mac OS"
    . "$SCRIPT_DIR/macos/100_system.sh"
    . "$SCRIPT_DIR/macos/101_apps.sh"
    . "$SCRIPT_DIR/macos/120_ui.sh"
    . "$SCRIPT_DIR/macos/140_dev.sh"
    . "$SCRIPT_DIR/macos/150_tools.sh"
    . "$SCRIPT_DIR/macos/160_mcp.sh"
else
    log_info "Setting up Linux"
    . "$SCRIPT_DIR/linux/100_system.sh"
    . "$SCRIPT_DIR/linux/101_apps.sh"
    . "$SCRIPT_DIR/linux/120_ui.sh"
fi

log_info "Running final checks"

# Verify shell setup
if [ "$SHELL" != "/bin/zsh" ]; then
    log_warning "ZSH is not set as default shell"
fi

log_h1 "Bootstrap complete!"
exit 0
