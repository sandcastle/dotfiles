#!/bin/bash
# Main installation script

set -euo pipefail
trap 'error_handler $? $LINENO $BASH_LINENO "$BASH_COMMAND" $(printf "::%s" ${FUNCNAME[@]:-})' ERR

# Source helper functions
source "$(dirname "${BASH_SOURCE[0]}")/bootstrap/_funcs.sh"

# Initial setup
clear
printf "\033[1;36m  _____        _    __ _ _            \033[0m\n"
printf "\033[1;34m |  __ \      | |  / _(_) |           \033[0m\n"
printf "\033[1;35m | |  | | ___ | |_| |_ _| | ___  ___  \033[0m\n"
printf "\033[1;33m | |  | |/ _ \| __| _| | |/ _ \/ __| \033[0m\n"
printf "\033[1;32m | |__| | (_) | |_| | | | |  __/\__ \ \033[0m\n"
printf "\033[1;31m |_____/ \___/ \__|_| |_|_|\___||___/ \033[0m\n"

echo ""
echo "Welcome to the dotfiles installer!"
echo "This will set up your macOS system with a complete development environment."
echo

# Get user preferences
prompt_user "Enter your computer name" COMPUTER_NAME "$(scutil --get ComputerName)"
prompt_user "Enter your Git name" GIT_NAME "$(git config --global user.name 2>/dev/null)"
prompt_user "Enter your Git email" GIT_EMAIL "$(git config --global user.email 2>/dev/null)"
echo ""

# Export for use in other scripts
export COMPUTER_NAME GIT_NAME GIT_EMAIL

# Set work directory
DOTFILES="$HOME/Developer/dotfiles"

# Create backup
BACKUP_DIR="$HOME/.backup/dotfiles/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Repository setup
if [[ -d "$DOTFILES" ]]; then
    echo "Updating existing dotfiles repository..."
    cd "$DOTFILES"
    git pull
else
    echo "Cloning dotfiles repository..."
    mkdir -p "$DOTFILES"
    git clone --depth 1 git://github.com/sandcastle/dotfiles.git "$DOTFILES"
    cd "$DOTFILES"
fi

# Get the directory of this script
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

chmod +x "$DOTFILES/install-symlink.sh"
chmod +x "$DOTFILES/bootstrap/bootstrap.sh"

# Symlink files
if ! ./install-symlink.sh; then
    echo "Error running symlink setup"
    exit 1
fi

# Bootstrap the system
"$DOTFILES/bootstrap/bootstrap.sh"

# Final message
cat << "EOF"

✨ Installation complete! ✨

A few things to do:
1. Restart your terminal to apply all changes
2. Run 'p10k configure' if you want to customize your prompt
3. Check the README for additional customization options

Enjoy your new setup! 🚀
EOF
