#!/bin/bash
# Main installation script

set -euo pipefail
trap 'error_handler $? $LINENO $BASH_LINENO "$BASH_COMMAND" $(printf "::%s" ${FUNCNAME[@]:-})' ERR

# Source helper functions
source "$(dirname "${BASH_SOURCE[0]}")/bootstrap/_funcs.sh"

# Initial setup
clear
printf "\033[34m _____      _    __ _ _           \033[0m\n"
printf "\033[34m|  __ \    | |  / _(_) |          \033[0m\n"
printf "\033[34m| |  | | __| |_| |_ _| | ___  ___ \033[0m\n"
printf "\033[34m| |  |  / _  |  _  | | |/ _ \/ __| \033[0m\n"
printf "\033[34m| |__| | (_| | | | | | |  __/\__ \ \033[0m\n"
printf "\033[34m|_____/ \__,_|_| |_|_|_|\___||___/ \033[0m\n"

echo ""
echo "Welcome to the dotfiles installer!"
echo "This will set up your macOS system with a complete development environment."
echo

# Get user preferences
prompt_user "Enter your computer name" COMPUTER_NAME "$(scutil --get ComputerName)"
prompt_user "Enter your Git name" GIT_NAME "$(git config --global user.name 2>/dev/null)"
prompt_user "Enter your Git email" GIT_EMAIL "$(git config --global user.email 2>/dev/null)"

# Export for use in other scripts
export COMPUTER_NAME GIT_NAME GIT_EMAIL

# Set work directory
DOT_FILES="$HOME/Developer/dotfiles"

# Create backup
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Repository setup
if [[ -d "$DOT_FILES" ]]; then
    echo "Updating existing dotfiles repository..."
    cd "$DOT_FILES"
    git pull
else
    echo "Cloning dotfiles repository..."
    mkdir -p "$DOT_FILES"
    git clone --recursive git://github.com/sandcastle/dotfiles.git "$DOT_FILES"
    cd "$DOT_FILES"
fi

# Get the directory of this script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run symlink setup
if ! ./install-symlink.sh; then
    echo "Error running symlink setup"
    exit 1
fi

# Make bootstrap script executable and run it
chmod +x "$DOTFILES_DIR/bootstrap/bootstrap.sh"
"$DOTFILES_DIR/bootstrap/bootstrap.sh"

# Final message
cat << "EOF"

✨ Installation complete! ✨

A few things to do:
1. Restart your terminal to apply all changes
2. Run 'p10k configure' if you want to customize your prompt
3. Check the README for additional customization options

Enjoy your new setup! 🚀
EOF
