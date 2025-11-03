#!/usr/bin/env bash

# Git
# https://git-scm.com/
echo "Installing Git..."

# Enable bash completion
sudo apt update

# Install git if not already installed
if [! command -v git >/dev/null 2>&1]; then
  sudo apt install -y git
fi

# Install bash completion
sudo apt install -y bash-completion
