#!/usr/bin/env bash

log_info "Running Linux initialization..."

if ! is_linux; then
    log_info "Skipping Linux initialization on non-Linux system"
    exit 0
fi

# Update package lists
if command -v apt-get >/dev/null; then
    log_info "Updating apt package lists"
    sudo apt-get update
elif command -v dnf >/dev/null; then
    log_info "Checking for dnf updates"
    sudo dnf check-update
elif command -v pacman >/dev/null; then
    log_info "Syncing pacman database"
    sudo pacman -Sy
fi
