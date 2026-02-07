#!/bin/bash

brew install neovim

# Only clone LazyVim starter if Neovim has never been configured
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi

# Ensure target directories exist
mkdir -p ~/.config/nvim/lua/config
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/nvim/plugin/after

# Symlink custom config files (overrides LazyVim defaults)
for file in "$DOTFILES_PATH"/configs/neovim/lua/config/*.lua; do
  ln -sf "$file" "$HOME/.config/nvim/lua/config/$(basename "$file")"
done

for file in "$DOTFILES_PATH"/configs/neovim/lua/plugins/*.lua; do
  ln -sf "$file" "$HOME/.config/nvim/lua/plugins/$(basename "$file")"
done

for file in "$DOTFILES_PATH"/configs/neovim/plugin/after/*.lua; do
  ln -sf "$file" "$HOME/.config/nvim/plugin/after/$(basename "$file")"
done

# Symlink theme
ln -sf "$DOTFILES_PATH/themes/tokyo-night/neovim.lua" "$HOME/.config/nvim/lua/plugins/theme.lua"
