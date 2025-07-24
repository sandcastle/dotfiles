#!/usr/bin/env bash

THEME="${1:-tokyo-night}"

# Neovim
if [ -f $DOTFILES_PATH/themes/$THEME/neovim.lua ]; then
  cp $DOTFILES_PATH/themes/$THEME/neovim.lua ~/.config/nvim/lua/plugins/theme.lua
fi

# VSCode
if [ -f $DOTFILES_PATH/themes/$THEME/vscode.sh ]; then
  source $DOTFILES_PATH/themes/$THEME/vscode.sh
fi

# Cursor
if [ -f $DOTFILES_PATH/themes/$THEME/cursor.sh ]; then
  source $DOTFILES_PATH/themes/$THEME/cursor.sh
fi
