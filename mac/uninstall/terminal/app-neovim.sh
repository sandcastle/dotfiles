#!/bin/bash

brew uninstall neovim

# Cleanup config and cache
rm ~/.config/nvim
rm ~/.local/share/nvim
rm ~/.local/state/nvim
rm ~/.cache/nvim
