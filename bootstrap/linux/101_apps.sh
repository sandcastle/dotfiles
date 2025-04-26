#!/usr/bin/env bash

log_h1 "Installing Linux apps"

install_package "fd-find" # Simple, fast alternative to find
install_package "build-essential"

log_success "Linux apps installed"
