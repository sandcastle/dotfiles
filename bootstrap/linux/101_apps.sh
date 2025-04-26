#!/usr/bin/env bash

log_h1 "Installing Linux apps"

install_package "fd-find" # Simple, fast alternative to find
install_package "build-essential"

# MSIE - https://mise.jdx.dev/
run_command "Installing MSIE" $(curl -s https://mise.run | MISE_QUIET=1 MISE_INSTALL_HELP=0 sh -s >/dev/null 2>&1)

log_success "Linux apps installed"
