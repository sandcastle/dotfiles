#!/bin/bash

echo "Running Linux initialization..."

# Source common functions
source "$(dirname "$0")/../_funcs.sh"

if ! is_linux; then
    echo "Skipping Linux initialization on non-Linux system"
    exit 0
fi

# Update package lists
if command -v apt-get >/dev/null; then
    sudo apt-get update
elif command -v dnf >/dev/null; then
    sudo dnf check-update
elif command -v pacman >/dev/null; then
    sudo pacman -Sy
fi
