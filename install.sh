#!/usr/bin/env bash

# Basic error handler without complex Bash-specific variables
error_handler() {
  echo "Error occurred at line $1"
  exit 1
}

trap 'error_handler $LINENO' ERR

# Check Bash version and compatibility
if [ -z "${BASH_VERSION:-}" ]; then
  echo "Error: This script requires Bash to run."
  exit 1
fi

# Extract bash major and minor version
BASH_MAJOR_VERSION=$(echo "$BASH_VERSION" | cut -d. -f1)
BASH_MINOR_VERSION=$(echo "$BASH_VERSION" | cut -d. -f2)

echo "Detected Bash version: $BASH_VERSION"

# Check for minimum version (Bash 3.2)
if [ "$BASH_MAJOR_VERSION" -lt 3 ] || ([ "$BASH_MAJOR_VERSION" -eq 3 ] && [ "$BASH_MINOR_VERSION" -lt 2 ]); then
  echo "Warning: This script works best with Bash 3.2 or higher."
  echo "Some features may not work as expected with your version: $BASH_VERSION"
  echo "Continuing in 5 seconds..."
  sleep 5
fi

# Detect OS
OS="$(uname -s)"
echo "Detected OS: $OS"

# Adjust settings based on Bash version
if [ "$BASH_MAJOR_VERSION" -ge 4 ]; then
  # Modern Bash - use full error handling
  set -euo pipefail
else
  # Legacy Bash - use simpler error handling
  set -e
fi 


get_script_directory() {
  # Works in both Bash and Zsh
  SOURCE="${BASH_SOURCE[0]:-${(%):-%x}}"

  while [ -L "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE"
  done

  cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd
}

export DOTFILES="$(get_script_directory)"

# Load helper functions using a more compatible approach
source "$DOTFILES/bootstrap/_funcs.sh"


# Initial setup
clear
printf "\033[1;36m  _____        _    __ _ _            \033[0m\n"
printf "\033[1;34m |  __ \      | |  / _(_) |           \033[0m\n"
printf "\033[1;35m | |  | | ___ | |_| |_ _| | ___  ___  \033[0m\n"
printf "\033[1;33m | |  | |/ _ \| __| _| | |/ _ \/ __|  \033[0m\n"
printf "\033[1;32m | |__| | (_) | |_| | | | |  __/\__ \ \033[0m\n"
printf "\033[1;31m |_____/ \___/ \__|_| |_|_|\___||___/ \033[0m\n"

echo ""
echo "Welcome to the dotfiles installer!"
echo "This will set up your system with a complete development environment."
echo

# Get user preferences with OS-specific defaults
if [ "$OS" = "Darwin" ]; then
  # macOS specific
  COMPUTER_NAME_DEFAULT="$(scutil --get ComputerName 2>/dev/null || hostname)"
else
  # Linux/other OS
  COMPUTER_NAME_DEFAULT="$(hostname)"
fi

prompt_user "Enter your computer name" COMPUTER_NAME "$COMPUTER_NAME_DEFAULT"
prompt_user "Enter your Git name" GIT_NAME "$(git config --global user.name 2>/dev/null || echo "")"
prompt_user "Enter your Git email" GIT_EMAIL "$(git config --global user.email 2>/dev/null || echo "")"
echo ""

# Export for use in other scripts
export COMPUTER_NAME GIT_NAME GIT_EMAIL OS

# Create backup
export BACKUP_DIR="$HOME/.backup/dotfiles/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Repository setup
if [ -d "$DOTFILES" ]; then
    echo "Updating existing dotfiles repository..."
    cd "$DOTFILES"
    git pull
else
    echo "Cloning dotfiles repository..."
    mkdir -p "$DOTFILES"
    git clone --depth 1 git://github.com/sandcastle/dotfiles.git "$DOTFILES"
    cd "$DOTFILES"
fi

# Symlink files
chmod +x "$DOTFILES/install-symlink.sh"
if ! "$DOTFILES/install-symlink.sh"; then
    echo "Error running symlink setup"
    exit 1
fi

# Bootstrap the system
chmod +x "$DOTFILES/bootstrap/bootstrap.sh"
if ! "$DOTFILES/bootstrap/bootstrap.sh"; then
    echo "Error running bootstrap"
    exit 1
fi

# Final message
cat << "EOF"

✨ Installation complete! ✨

A few things to do:
1. Restart your terminal to apply all changes
2. Check the README for additional customization options

Enjoy your new setup! 🚀
EOF
