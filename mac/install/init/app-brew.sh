#!/usr/bin/env bash

# Install Homebrew if not installed
if ! command -v brew >/dev/null; then
  # MacOS comes with bash (old) and curl
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew Autoupdate
brew tap domt4/autoupdate

# Required for sudo (casks that need sudo)
brew install pinentry-mac

# Schedule for every hour to upgrade and cleanup
brew autoupdate start 3600 --upgrade --cleanup --sudo
