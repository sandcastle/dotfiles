#!/usr/bin/env bash
# macOS specific settings

source "$(dirname "$0")/_funcs.sh"

if ! is_macos; then
    echo "Skipping macOS settings on non-macOS system"
    exit 0
fi

print_heading "Configuring macOS settings"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Setting computer name..."
if [[ -z "${COMPUTER_NAME}" ]]; then
    echo "Enter new hostname of the machine (e.g. macbook-pro):"
    read -r COMPUTER_NAME
fi

if [[ -n "${COMPUTER_NAME}" ]]; then
    sudo scutil --set ComputerName "$COMPUTER_NAME"
    sudo scutil --set HostName "$COMPUTER_NAME"
    sudo scutil --set LocalHostName "$COMPUTER_NAME"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"
fi

###############################################################################
# General UI/UX                                                                 #
###############################################################################

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

###############################################################################
# Dock                                                                         #
###############################################################################

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Make dock show instantly when hidden
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock autohide-delay -int 0

# Show which apps are hidden
defaults write com.apple.dock showhidden -bool true

# Position on screen
defaults write com.apple.dock orientation -string "right"

# Automatically hide and show
defaults write com.apple.dock autohide -bool true

# Enable magnification
defaults write com.apple.dock magnification -bool true

# Icon size
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock largesize -int 64

###############################################################################
# Finder                                                                       #
###############################################################################

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

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

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Keyboard & Input                                                             #
###############################################################################

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

###############################################################################
# Screen                                                                       #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Chrome                                                                       #
###############################################################################

# Disable swipe navigation
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

###############################################################################
# Kill affected applications                                                   #
###############################################################################

for app in "Dock" "Finder" "SystemUIServer" "cfprefsd"; do
    killall "${app}" &> /dev/null
done

echo "macOS settings updated successfully!" 