#!/usr/bin/env bash

# Install Homebrew if not installed
if ! command -v brew >/dev/null; then
  # MacOS comes with bash (old) and curl
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
