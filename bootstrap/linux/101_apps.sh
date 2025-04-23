#!/usr/bin/env bash

log_h1 "Installing Linux apps"

install_package "fd-find"         # Simple, fast alternative to find
install_package "build-essential"
install_package "neovim"
install_package "vim"
install_package "zsh"

log_success "Linux apps installed"
