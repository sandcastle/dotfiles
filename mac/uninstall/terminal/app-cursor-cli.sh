#!/usr/bin/env bash

# Cursor CLI
# https://www.cursor.com/

# Remove cli
brew uninstall cursor-cli

# cleanup config files
rm ~/.local/bin/cursor-agent &> /dev/null || true
rm ~/.local/share/cursor-agent &> /dev/null || true
