#!/usr/bin/env bash

# Uninstall all terminal application scripts
echo "Uninstalling terminal applications..."

source "$DOTFILES_OS_PATH/uninstall/terminal/app-cmctl.sh"
source "$DOTFILES_OS_PATH/uninstall/terminal/app-git.sh"
source "$DOTFILES_OS_PATH/uninstall/terminal/app-terraform.sh"
source "$DOTFILES_OS_PATH/uninstall/terminal/app-zoxide.sh"

echo "Terminal applications uninstallation complete."
