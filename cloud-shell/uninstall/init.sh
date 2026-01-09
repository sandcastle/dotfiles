#!/usr/bin/env bash

# Uninstall all init scripts
echo "Uninstalling init scripts..."

# Uninstall gum
source "$DOTFILES_OS_PATH/uninstall/init/app.gum.sh"

echo "Init scripts uninstallation complete."
