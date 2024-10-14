#!/usr/bin/env zsh

# dev
mkdir ~/Developer


## Dock

# Set the duration of the Dock animation to 0.5 seconds.
defaults write com.apple.dock autohide-time-modifier -float 0.5
# Configure the Dock to have the fastest response time.
defaults write com.apple.dock autohide-delay -int 0


## Launch Pad

# Specify the number of columns to be used.
defaults write com.apple.dock springboard-columns -int 10
# Specify the number of rows to be used.
defaults write com.apple.dock springboard-rows -int 8


## Finder

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# expand save dialog by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true


## Chrome

# Prevent left and right swipe through history in Chrome
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false


## Keyboard

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15


## Safari

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true


for app in Safari Finder Dock SystemUIServer; do killall "$app" >/dev/null 2>&1; done