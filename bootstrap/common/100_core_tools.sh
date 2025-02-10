#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

print_heading "Installing common tools"

# core tools
install_package "git"
install_package "gh"
install_package "fzf"
install_package "ripgrep"
install_package "fd"
install_package "jq"
install_package "yq"
install_package "tree"
install_package "wget"
install_package "curl"

# modern replacements
install_package "bat"
install_package "eza"
install_package "delta"
install_package "zoxide"
install_package "duf"
install_package "bottom"

# monitoring tools
install_package "cloc"
install_package "httpie"
install_package "trash"
install_package "watch"
install_package "htop"
install_package "ncdu"
