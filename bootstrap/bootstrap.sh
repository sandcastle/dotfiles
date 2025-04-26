#!/usr/bin/env bash
set -e && ( set -o pipefail; ) 2>/dev/null || true

# Get current directory, works in both source and execution contexts
if [[ -n "${BASH_SOURCE[0]}" ]]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
elif [[ -n "$0" ]]; then
    SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
else
    echo "Error: Cannot determine script location" >&2
    exit 1
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

require_sudo

# Installation phases
. "$SCRIPT_DIR/common/init.sh"
if [ "$OS_TYPE" = "macos" ]; then
    . "$SCRIPT_DIR/macos/init.sh"
else
    . "$SCRIPT_DIR/linux/init.sh"
fi

. "$SCRIPT_DIR/common/100_apps.sh"
. "$SCRIPT_DIR/common/101_shell.sh"

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

log_h1 "Bootstrap complete!"
exit 0
