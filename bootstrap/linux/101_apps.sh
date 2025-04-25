#!/usr/bin/env bash

log_h1 "Installing Linux apps"

install_package "fd-find"         # Simple, fast alternative to find
install_package "build-essential"
install_package "neovim"
install_package "vim"
install_package "zsh"

# MSIE - https://mise.jdx.dev/
run_with_progress "Installing MSIE" true curl -fsSL https://mise.run | sh -s -- -y

log_success "Linux apps installed"
