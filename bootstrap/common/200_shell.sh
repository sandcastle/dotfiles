#!/bin/bash
# Shell setup

source "$(dirname "$0")/_funcs.sh"

print_heading "Setting up shell environment"

# Install shell and plugins
if is_macos; then
    # On macOS, use Homebrew
    install_packages "zsh" "starship" "zsh-completions" "zsh-syntax-highlighting" "zsh-autosuggestions"
else
    # On Linux, use native package manager
    if command -v apt-get >/dev/null; then
        # Debian/Ubuntu
        install_packages "zsh" "starship" "zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-autocomplete"
    elif command -v dnf >/dev/null; then
        # Fedora
        install_packages "zsh" "starship" "zsh-syntax-highlighting" "zsh-autosuggestions"
    elif command -v pacman >/dev/null; then
        # Arch Linux
        install_packages "zsh" "starship" "zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-completions"
    fi
fi

# Install Oh My Zsh if not already installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_success "Oh My Zsh installed successfully"
fi

# Install Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    log_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    log_success "Powerlevel10k theme installed successfully"
fi

# Set ZSH as default shell if not already
if [[ $SHELL != "/bin/zsh" ]]; then
    log_info "Setting ZSH as default shell..."
    chsh -s /bin/zsh
    log_success "ZSH set as default shell"
fi

# Source zsh configuration
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi

# Create symlinks for dotfiles
"$(dirname "$0")/../install-symlink.sh"
