#!/bin/bash

cd /tmp
wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
tar -xf nvim.tar.gz
sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
sudo cp -R nvim-linux-x86_64/lib /usr/local/
sudo cp -R nvim-linux-x86_64/share /usr/local/
rm -rf nvim-linux-x86_64 nvim.tar.gz
cd -

# Install luarocks and tree-sitter-cli to resolve lazyvim :checkhealth warnings
sudo apt install -y luarocks tree-sitter-cli

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
