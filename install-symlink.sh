#!/usr/bin/env bash

# This file is called by install.sh; it symlinks dotfiles to the $HOME path

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source functions
source "$DOTFILES/bootstrap/_funcs.sh"

# Create backup directory
BACKUP_DIR="$HOME/.backup/dotfiles/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

create_symlink() {
    local src="$1"
    local dest="$2"
    local use_sudo="$3"
    local filename=$(basename "$src")

    # Handle existing destination
    if [[ -e "$dest" || -L "$dest" ]]; then
        # Check if it's already a symlink to our target
        if [[ -L "$dest" ]]; then
            local current_target=$(readlink "$dest")

            if [[ "$current_target" == "$src" ]]; then
                log_success "Already linked: $dest"
                return 0
            else
                log_warning "Replacing symlink $dest, old link: $current_target"
            fi
        else
            log_warning "Backing up existing file: $dest"
        fi

        # Backup existing file or symlink
        if [[ "$use_sudo" == "true" ]]; then
            sudo cp -P "$dest" "$BACKUP_DIR/" 2>/dev/null || true
            # Try to remove, but don't fail if the file is busy
            sudo rm -f "$dest" 2>/dev/null || {
                log_warning "Cannot remove $dest - file is in use. Skipping..."
                return 1
            }
        else
            cp -P "$dest" "$BACKUP_DIR/" 2>/dev/null || true
            rm -f "$dest" 2>/dev/null || {
                log_warning "Cannot remove $dest - file is in use. Skipping..."
                return 1
            }
        fi
    fi

    # Create new symlink
    if [[ "$use_sudo" == "true" ]]; then
        sudo ln -sf "$src" "$dest"
    else
        ln -sf "$src" "$dest"
    fi

    # Verify symlink was created correctly
    if [[ -L "$dest" ]]; then
        local actual_target=$(readlink "$dest")
        if [[ "$actual_target" == "$src" ]]; then
            log_success "Linked: $dest → $src"
        else
            log_error "Symlink points to $actual_target instead of $src"
        fi
    else
        log_error "Failed to create symlink"
    fi
}

symlink_directory() {
    local src_dir="$1"
    local dest_dir="$2"
    local use_sudo="$3"

    log_h3 "Symlinking directory $src_dir"

    # Create destination directory if it doesn't exist
    if [[ "$use_sudo" == "true" ]]; then
        sudo mkdir -p "$dest_dir"
    else
        mkdir -p "$dest_dir"
    fi

    # Iterate over all files in source directory
    if [[ -d "$src_dir" ]]; then
        local file_count=0

        # Enable dotglob to match hidden files
        shopt -s dotglob

        for file in "$src_dir"/*; do
            # Skip . and .. directories
            if [[ "$(basename "$file")" == "." || "$(basename "$file")" == ".." ]]; then
                continue
            fi

            if [[ -f "$file" ]]; then
                local filename=$(basename "$file")
                local dest="$dest_dir/$filename"
                file_count=$((file_count + 1))
                create_symlink "$file" "$dest" "$use_sudo"
            fi
        done

        # Reset dotglob
        shopt -u dotglob
    else
        log_warning "Source directory does not exist: $src_dir"
        return 1
    fi

    log_finished "Processed $file_count files"
}

symlink_file() {
    local src="$1"
    local dest="$2"
    local use_sudo="$3"

    # Check if source file exists
    if [[ ! -f "$src" ]]; then
        echo "Source file does not exist: $src"
        return 1
    fi

    # Create the parent directory if it doesn't exist
    local parent_dir=$(dirname "$dest")
    if [[ "$use_sudo" == "true" ]]; then
        sudo mkdir -p "$parent_dir"
    else
        mkdir -p "$parent_dir"
    fi

    create_symlink "$src" "$dest" "$use_sudo"
}

log_h1 "Symlinking dotfiles"

log_info "Dotfiles: $DOTFILES"

symlink_directory "$DOTFILES/home" "$HOME" "false"
symlink_directory "$DOTFILES/home/.config" "$HOME/.config" "false"
symlink_directory "$DOTFILES/etc" "/etc" "true"

log_finished "All files symlinked"
