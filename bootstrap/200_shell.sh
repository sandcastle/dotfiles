#!/bin/bash
# Shell setup

source "$(dirname "$0")/_funcs.sh"

print_heading "Setting up shell environment"

# Install shell and plugins
install_brew "zsh"
install_brew "starship"       # Modern prompt
install_brew "zsh-completions"
install_brew "zsh-syntax-highlighting"
install_brew "zsh-autosuggestions"

# Install Oh My Zsh if not already installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Set ZSH as default shell if not already
if [[ $SHELL != "/bin/zsh" ]]; then
    echo "Setting ZSH as default shell..."
    chsh -s /bin/zsh
fi 