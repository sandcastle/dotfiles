#!/bin/bash

print_heading "Configuring macOS system settings"

# Ask for computer name if not set
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

# System-wide settings
sudo nvram SystemAudioVolume=" "  # Disable boot sound
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false  # Save to disk by default
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2  # Set sidebar icon size to medium
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Security settings
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "System settings configured successfully" 