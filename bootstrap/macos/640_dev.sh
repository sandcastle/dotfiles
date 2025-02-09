#!/bin/bash

echo "Configuring developer settings..."

# dev
mkdir ~/Developer

# Xcode command line tools check/install
if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
fi

