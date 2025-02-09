#!/bin/bash

echo "Configuring UI preferences..."

# Dock settings
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36

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


## Keyboard

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15


# Restart all

for app in Safari Finder Dock SystemUIServer; do killall "$app" >/dev/null 2>&1; done
