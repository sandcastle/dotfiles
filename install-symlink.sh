#!/usr/bin/env bash

# This file is called by install.sh; it symlinks dotfiles to the $HOME path

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source functions
source "$DOTFILES/bootstrap/_funcs.sh"

# Create backup directory
BACKUP_DIR="$HOME/.backup/dotfiles/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to safely create symlinks
create_symlink() {
    local src="$1"
    local dest="$2"
    local use_sudo="$3"
    
    # Create symlink (silently)
    if [[ "$use_sudo" == "true" ]]; then
        sudo ln -sf "$src" "$dest"
    else
        ln -sf "$src" "$dest"
    fi
}

# Function to symlink all files from a directory
symlink_directory() {
    local src_dir="$1"
    local dest_dir="$2"
    local use_sudo="$3"
    local backup_count=0
    local symlink_count=0
    
    # Create destination directory if it doesn't exist
    if [[ "$use_sudo" == "true" ]]; then
        sudo mkdir -p "$dest_dir"
    else
        mkdir -p "$dest_dir"
    fi
    
    # Iterate over all files in source directory
    for file in "$src_dir"/*; do
        if [[ -f "$file" ]]; then
            local filename=$(basename "$file")
            local dest="$dest_dir/$filename"

            # Backup existing file if it exists
            if [[ -e "$dest" ]]; then
                if [[ "$use_sudo" == "true" ]]; then
                    sudo mv "$dest" "$BACKUP_DIR/"
                else
                    cp "$dest" "$BACKUP_DIR/"
                fi
                ((backup_count++))
            fi
            
            # Create symlink
            create_symlink "$file" "$dest" "$use_sudo" symlink_count
            ((symlink_count++))
        fi
    done
    
    # Print results for this directory
    log_finished "Symlinked files in $dest_dir" true \
        "$backup_count files backed up to $BACKUP_DIR" \
        "$symlink_count symlinks created"
}

# Dynamically symlink all files from home directory
echo "Symlinking dotfiles from home directory..."

# Symlink remaining files from home directory
symlink_directory "$DOTFILES/home" "$HOME" "false"
symlink_directory "$DOTFILES/home/.config" "$HOME/.config" "false"

# Symlink /etc files
echo "Symlinking /etc"
symlink_directory "$DOTFILES/etc" "/etc" "true"
