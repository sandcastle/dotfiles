#!/usr/bin/env sh

# Install Bundler if not installed
if ! gem list bundler -i >/dev/null 2>&1; then
  echo "Installing Bundler..."
  gem install bundler
  rbenv rehash
else
  echo "Bundler is already installed."
fi

# Install kamal gem (or any other essential gems)
INSTALL_GEMS=("kamal")  # Add other gems as needed

for gem in "${INSTALL_GEMS[@]}"; do
  if ! gem list "$gem" -i >/dev/null 2>&1; then
    echo "Installing gem: $gem..."
    gem install "$gem"
    rbenv rehash
  else
    echo "Gem '$gem' is already installed."
  fi
done