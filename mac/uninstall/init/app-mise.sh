#!/usr/bin/env bash

# Mise
# https://mise.jdx.dev/installing-mise.html#uninstalling

brew uninstall mise

# Remove config files and directories
rm ~/.mise &> /dev/null || true
rm ~/.config/mise &> /dev/null || true
rm ~/.local/share/mise &> /dev/null || true
rm ~/.local/state/mise &> /dev/null || true

# Remove cache files
rm ~/Library/Caches/mise &> /dev/null || true
