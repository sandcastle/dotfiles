#!/usr/bin/env bash

# Install gems
INSTALL_GEMS=("bundler")

for gem in "${INSTALL_GEMS[@]}"; do
  if ! gem list "$gem" -i >/dev/null 2>&1; then
    echo "Installing gem: $gem"
    gem install "$gem"
    rbenv rehash
  fi
done
