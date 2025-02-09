#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

print_heading "Installing common tools"

core_tools=(
    "git"
    "gh"
    "fzf"
    "ripgrep"
    "fd"
    "jq"
    "yq"
    "tree"
    "wget"
    "curl"
)

modern_replacements=(
    "bat"           # Better cat
    "exa"           # Better ls
    "delta"         # Better git diff
    "zoxide"        # Better cd
    "duf"           # Better df
    "bottom"        # Better top
)

monitoring_tools=(
    "cloc"          # For 'lines' alias
    "httpie"        # For HTTP client aliases
    "trash"         # For safe rm
    "watch"         # For monitoring commands
    "htop"          # Process monitoring
    "ncdu"          # Disk usage analysis
)

# Install all categories
install_packages "${core_tools[@]}"
install_packages "${modern_replacements[@]}"
install_packages "${monitoring_tools[@]}" 
