#!/usr/bin/env bash

# Install all terminal application scripts
echo "Installing terminal applications..."

source "$DOTFILES_OS_PATH/install/terminal/app-cmctl.sh"
source "$DOTFILES_OS_PATH/install/terminal/app-git.sh"
source "$DOTFILES_OS_PATH/install/terminal/app-terraform.sh"
source "$DOTFILES_OS_PATH/install/terminal/app-zoxide.sh"

echo "Terminal applications installation complete."
