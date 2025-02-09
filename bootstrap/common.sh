#!/bin/bash

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install common Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Create symlinks for dotfiles
"$(dirname "$0")/../install-symlink.sh"

# Set zsh as default shell if it isn't already and if we're not in a cloud environment
if [ "$SHELL" != "$(which zsh)" ] && [ -z "$CLOUD_SHELL" ]; then
    chsh -s "$(which zsh)"
fi

# Source zsh configuration
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi 