#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

log_h1 "Configuring UI preferences"

# Dock settings
log_success "Configuring Dock settings"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36

## Dock animation
log_success "Configuring Dock animations"
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock autohide-delay -int 0

## Launch Pad
log_success "Configuring LaunchPad layout"
defaults write com.apple.dock springboard-columns -int 10
defaults write com.apple.dock springboard-rows -int 8

## Keyboard
log_success "Configuring keyboard settings"
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15

## Finder
log_success "Configuring Finder preferences"
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g AppleShowAllFiles -bool true && killall Finder
defaults write com.apple.Finder ShowPathbar -bool true
defaults write com.apple.Finder ShowStatusBar -bool true
defaults write com.apple.Finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.Finder _FXSortFoldersFirst -bool true
defaults write com.apple.Finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.Finder FXEnableExtensionChangeWarning -bool false

## Safari
log_success "Configuring Safari preferences"
sudo defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Restart UI components
log_success "Restarting UI components"
# Temporarily disable exit on error
set +e
for app in Safari Finder Dock SystemUIServer; do 
    killall "$app" >/dev/null 2>&1
done
# Re-enable exit on error
set -e
