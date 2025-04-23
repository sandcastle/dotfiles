#!/usr/bin/env bash

log_h1 "Configuring Linux system settings"

# Computer name
if [ -n "$COMPUTER_NAME" ]; then
    read -p "Do you want to set the computer name to '$COMPUTER_NAME'? (y/N) " yn
    if [ "$yn" = "y" ] || [ "$yn" = "Y" ]; then
        sudo hostnamectl set-hostname "$COMPUTER_NAME"
    fi
fi
