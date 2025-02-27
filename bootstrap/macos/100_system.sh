#!/bin/bash

print_heading "Configuring macOS system settings"

# Ask for computer name if not set
if [[ -z "${COMPUTER_NAME}" ]]; then
    log_info "Computer name not set"
    echo "Enter new hostname of the machine (e.g. macbook-pro):"
    read -r COMPUTER_NAME
fi

if [[ -n "${COMPUTER_NAME}" ]]; then
    CURRENT_NAME=$(scutil --get ComputerName)
    if [[ "$CURRENT_NAME" != "$COMPUTER_NAME" ]]; then
        log_info "Setting computer name to: $COMPUTER_NAME"
        sudo scutil --set ComputerName "$COMPUTER_NAME"
        sudo scutil --set HostName "$COMPUTER_NAME"
        sudo scutil --set LocalHostName "$COMPUTER_NAME"
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"
    else
        log_info "Computer name is already set to: $COMPUTER_NAME"
    fi
fi

# System-wide settings
log_info "Configuring system-wide settings"
sudo nvram SystemAudioVolume=" "  # Disable boot sound
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false  # Save to disk by default
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2  # Set sidebar icon size to medium
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Security settings
log_info "Configuring security settings"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

log_success "System settings configured successfully" 