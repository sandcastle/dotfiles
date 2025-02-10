#!/bin/bash

source "$(dirname "$0")/_funcs.sh"

print_heading "Setting up shell environment"

# Install shell and plugins
if is_macos; then
    # On macOS, use Homebrew
    install_package "zsh"
    install_package "starship"
    install_package "zsh-completions"
    install_package "zsh-syntax-highlighting"
    install_package "zsh-autosuggestions"
else
    # On Linux, use native package manager
    if command -v apt-get >/dev/null; then
        # Debian/Ubuntu
        install_package "zsh"
        install_package "starship"
        install_package "zsh-syntax-highlighting"
        install_package "zsh-autosuggestions"
        install_package "zsh-autocomplete"
    elif command -v dnf >/dev/null; then
        # Fedora
        install_package "zsh"
        install_package "starship"
        install_package "zsh-syntax-highlighting"
        install_package "zsh-autosuggestions"
    elif command -v pacman >/dev/null; then
        # Arch Linux
        install_package "zsh"
        install_package "starship"
        install_package "zsh-syntax-highlighting"
        install_package "zsh-autosuggestions"
        install_package "zsh-completions"
    fi
fi

# Install Oh My Zsh if not already installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
        log_error "Failed to install Oh My Zsh"
        exit 1
    }
    log_success "Oh My Zsh installed successfully"
fi

# Install Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    log_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || {
        log_error "Failed to install Powerlevel10k theme"
        exit 1
    }
    log_success "Powerlevel10k theme installed successfully"
fi

# Check if zsh is installed and get its path
ZSH_PATH=$(command -v zsh || echo "/bin/zsh")
if [ ! -f "$ZSH_PATH" ]; then
    log_error "ZSH not found after installation"
    exit 1
fi

# Set ZSH as default shell if not already
if [[ "$SHELL" != *"zsh"* ]]; then
    log_info "Setting ZSH as default shell..."
    # Check if zsh is in /etc/shells, add it if not
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
    fi
    
    # Change shell
    chsh -s "$ZSH_PATH" || {
        log_error "Failed to change default shell to ZSH"
        exit 1
    }
    log_success "ZSH set as default shell"
fi
