#!/bin/bash

# This file is called by install.sh; it symlinks dotfiles to the $HOME path

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source functions
source "$DOTFILES_DIR/bootstrap/_funcs.sh"

# Create backup directory
BACKUP_DIR="$HOME/.backup/dotfiles/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Counters for summary
BACKUP_COUNT=0
SYMLINK_COUNT=0

# Function to safely create symlinks
create_symlink() {
    local src="$1"
    local dest="$2"
    
    # Backup existing file/directory if it exists
    if [[ -e "$dest" ]]; then
        # Silently backup the file
        mv "$dest" "$BACKUP_DIR/"
        ((BACKUP_COUNT++))
    fi

    # Create symlink (silently)
    ln -sf "$src" "$dest"
    ((SYMLINK_COUNT++))
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

# Display summary using log_finished function
log_finished "Symlinked home files" true \
    "$BACKUP_COUNT files backed up to $BACKUP_DIR" \
    "$SYMLINK_COUNT symlinks created"
