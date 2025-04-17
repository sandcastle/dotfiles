#!/usr/bin/env sh

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

log_h1 "Configuring Tools"

# Define directories
CURSOR_SETTINGS_DIR="$HOME/Library/Application Support/Cursor/User"
VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User/"

# Create backup directory with timestamp
BACKUP_DIR="$HOME/.backup/editor_settings/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to safely create symlinks
create_symlink() {
    local src="$1"
    local dest="$2"
    local dest_dir="$(dirname "$dest")"
    
    # Create destination directory if it doesn't exist
    mkdir -p "$dest_dir"
    
    # Backup existing file if it exists
    if [[ -e "$dest" ]]; then
        log_info "Backing up $dest to $BACKUP_DIR/"
        cp -R "$dest" "$BACKUP_DIR/$(basename "$dest")"
    fi

    # Create symlink
    log_info "Creating symlink: $dest -> $src"
    ln -sf "$src" "$dest"
}

link_tools() {
    # Symlink editor settings
    log_info "Linking tool settings files"

    # Cursor settings
    create_symlink "$DOTFILES/tools/cursor/settings.json" "$CURSOR_SETTINGS_DIR/settings.json"

    # VSCode settings
    create_symlink "$DOTFILES/tools/vscode/settings.json" "$VSCODE_SETTINGS_DIR/settings.json"

    log_success "Tools linked successfully"
}

run_with_progress "Linking tools" true link_tools
