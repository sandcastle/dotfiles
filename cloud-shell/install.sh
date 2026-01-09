#!/usr/bin/env bash

DOTFILES_OS="cloud-shell"

export DOTFILES_PATH="$HOME/.local/share/dotfiles"
export DOTFILES_OS_PATH="$DOTFILES_PATH/$DOTFILES_OS"

# update APT repositories
sudo apt-get update -y

source $DOTFILES_OS_PATH/install/init.sh
source $DOTFILES_OS_PATH/install/terminal.sh
