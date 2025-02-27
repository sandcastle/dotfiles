#!/bin/bash

# This file is called by install.sh; it symlinks dotfiles to the $HOME path

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to safely create symlinks
create_symlink() {
    local src="$1"
    local dest="$2"
    
    # Backup existing file/directory if it exists
    if [[ -e "$dest" ]]; then
        echo "Backing up $dest to $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    # Create symlink
    echo "Creating symlink: $dest -> $src"
    ln -sf "$src" "$dest"
}

# Dynamically symlink all files from home directory
echo "Symlinking dotfiles from home directory..."
for file in "$DOTFILES_DIR"/home/.*; do
    # Skip . and .. directories
    [[ $(basename "$file") == "." || $(basename "$file") == ".." ]] && continue
    
    # Create symlink for each file
    create_symlink "$file" "$HOME/$(basename "$file")"
done

# Create ZSH custom directory
ZSH_CUSTOM="$HOME/.zsh"
mkdir -p "$ZSH_CUSTOM"
create_symlink "$DOTFILES_DIR/zsh" "$ZSH_CUSTOM"
