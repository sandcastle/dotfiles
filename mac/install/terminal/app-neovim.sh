#!/bin/bash

brew install neovim

# Only attempt to set configuration if Neovim has never been run
if [ ! -d "~/.config/nvim" ]; then
  # Use LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim

  # Remove the .git folder, so you can add it to your own repo later
  rm ~/.config/nvim/.git

  # Make everything match the terminal transparency
  mkdir -p ~/.config/nvim/plugin/after
  cp $DOTFILES_PATH/configs/neovim/transparency.lua ~/.config/nvim/plugin/after/

  # Turn off animated scrolling
  cp $DOTFILES_PATH/configs/neovim/snacks-animated-scrolling-off.lua ~/.config/nvim/lua/plugins/

  # Default to Tokyo Night theme
  cp $DOTFILES_PATH/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

  # Turn off relative line numbers
  echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua
fi

# TODO: Add a desktop launcher
