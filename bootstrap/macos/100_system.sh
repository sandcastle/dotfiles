#!/usr/bin/env bash

log_h1 "Configuring MacOS system"

# Ask for computer name if not set
if [[ -z "${COMPUTER_NAME}" ]]; then
    log_info "Computer name not set"
    echo "Enter new hostname of the machine (e.g. macbook-pro):"
    read -r COMPUTER_NAME
fi

if [[ -n "${COMPUTER_NAME}" ]]; then
    CURRENT_NAME=$(scutil --get ComputerName)
    if [[ "$CURRENT_NAME" != "$COMPUTER_NAME" ]]; then
        log_success "Setting computer name to: $COMPUTER_NAME"
        sudo scutil --set ComputerName "$COMPUTER_NAME"
        sudo scutil --set HostName "$COMPUTER_NAME"
        sudo scutil --set LocalHostName "$COMPUTER_NAME"
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"
    else
        log_success "Computer name is already set to: $COMPUTER_NAME"
    fi
fi
