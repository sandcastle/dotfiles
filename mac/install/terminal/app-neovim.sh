#!/bin/bash

brew install neovim

# Only attempt to set configuration if Neovim has never been run
if [ ! -d "~/.config/nvim" ]; then
  # Use LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim

  # Remove the .git folder, so you can add it to your own repo later
  rm ~/.config/nvim/.git

  # Make everything match the terminal transparency
  mkdir -p ~/.config/nvim/plugin/after/

  # Copy config files
  cp -Rf $DOTFILES_PATH/configs/neovim/plugin/after/ ~/.config/nvim/plugin/after/
  cp -Rf $DOTFILES_PATH/configs/neovim/lua/ ~/.config/nvim/lua/

  # Default to Tokyo Night theme
  cp $DOTFILES_PATH/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua
fi

# ~/.local/share/dotfiles
# TODO: Add a desktop launcher
