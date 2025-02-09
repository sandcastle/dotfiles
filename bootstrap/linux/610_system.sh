#!/bin/bash

echo "Configuring system settings..."

# Computer name
if [ -n "$COMPUTER_NAME" ]; then
    sudo hostnamectl set-hostname "$COMPUTER_NAME"
fi

# System-level configurations
# Package manager updates
# System security settings 