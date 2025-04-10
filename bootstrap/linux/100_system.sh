#!/usr/bin/env sh

log_h1 "Configuring Linux system settings"

# Computer name
if [ -n "$COMPUTER_NAME" ]; then
    sudo hostnamectl set-hostname "$COMPUTER_NAME"
fi
