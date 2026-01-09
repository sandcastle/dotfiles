#!/usr/bin/env bash

DOTFILES_OS="cloud-shell"

export DOTFILES_PATH="$HOME/.local/share/dotfiles"
export DOTFILES_OS_PATH="$DOTFILES_PATH/$DOTFILES_OS"

source $DOTFILES_OS_PATH/uninstall/terminal.sh
source $DOTFILES_OS_PATH/uninstall/init.sh

echo "Cloud-shell uninstallation complete."
