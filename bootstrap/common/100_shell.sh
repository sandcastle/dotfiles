#!/usr/bin/env bash

log_h1 "Setting up shell"

# ZSH shell
install_package "zsh"

# Check if zsh is installed and get its path
ZSH_PATH=$(command -v zsh || echo "/bin/zsh")
if [ ! -f "$ZSH_PATH" ]; then
    log_error "ZSH not found after installation"
    exit 1
fi

# Install Oh My Zsh if not already installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_h3 "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_success "Oh My Zsh installed successfully"
fi

# Set ZSH as default shell if not already
if [[ "$SHELL" != *"zsh"* ]]; then
    log_h3 "Setting ZSH as default shell..."
    # Add ZSH to /etc/shells if not already present
    grep -q "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
    # Change shell
    sudo chsh -s "$ZSH_PATH"
    log_success "ZSH set as default shell"
fi

# Install plugins
install_package "starship"
install_package "zsh-autosuggestions"
install_package "zsh-completions"
install_package "zsh-fast-syntax-highlighting"
install_package "zsh-syntax-highlighting"

if is_macos; then
    # On macOS, use Homebrew
    install_package "zsh-completions"
elif command -v apt-get >/dev/null; then
    # Debian/Ubuntu
    install_package "zsh-autocomplete"
elif command -v pacman >/dev/null; then
    # Arch Linux
    install_package "zsh-completions"
fi
