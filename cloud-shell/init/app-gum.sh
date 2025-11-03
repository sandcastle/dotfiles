#!/usr/bin/env bash

# Gum
# https://github.com/charmbracelet/gum
echo "Installing Gum..."

echo "deb [trusted=yes] https://repo.charm.sh/apt/ /" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudoapt install -y gum
