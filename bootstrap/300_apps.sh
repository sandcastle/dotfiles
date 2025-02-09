#!/bin/bash
# Applications

source "$(dirname "$0")/_funcs.sh"

print_heading "Installing applications"

# Terminal
install_brew "iterm2"

# Development
install_brew "visual-studio-code" "Visual Studio Code" --cask
install_brew "docker" --cask

# Password manager
install_brew "1password" --cask
install_brew "1password-cli"

# Media
install_brew "vlc" --cask
install_brew "spotify" --cask
