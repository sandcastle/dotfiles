#!/bin/bash
# macOS Applications

source "$(dirname "$0")/../_funcs.sh"

if ! is_macos; then
    echo "Skipping macOS applications on non-macOS system"
    exit 0
fi

print_heading "Installing macOS applications"

# Define application categories
terminal_apps=(
    "iterm2"
)

dev_apps=(
    "visual-studio-code"
    "docker"
)

productivity_apps=(
    "1password"
    "1password-cli"
)

media_apps=(
    "vlc"
    "spotify"
)

# Install applications by category
for app in "${terminal_apps[@]}"; do
    install_brew "$app" "$app" --cask
done

for app in "${dev_apps[@]}"; do
    install_brew "$app" "$app" --cask
done

for app in "${productivity_apps[@]}"; do
    install_brew "$app" "$app" --cask
done

for app in "${media_apps[@]}"; do
    install_brew "$app" "$app" --cask
done

echo "Configuring application defaults..."

## Finder

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# expand save dialog by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Display full POSIX path as window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false


## Chrome

# Prevent left and right swipe through history in Chrome
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false


## Safari

# Enable Safari’s debug menu
sudo defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
