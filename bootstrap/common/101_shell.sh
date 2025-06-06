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

# Set ZSH as default shell if not already
if [[ "$SHELL" != *"zsh"* ]]; then
    log_h3 "Setting ZSH as default shell..."
    # Add ZSH to /etc/shells if not already present
    grep -q "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
    # Change shell
    sudo chsh -s "$ZSH_PATH" "$USER"
    log_success "ZSH set as default shell"
fi

run_command "Installing Starship" $(curl -sS https://starship.rs/install.sh | sh -s -- -y >/dev/null)
run_command "Installing Zi" $(curl -fsSL https://git.io/zi-install | bash -s -- --yes -i skip -a annex >/dev/null)
