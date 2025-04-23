#!/usr/bin/env bash

set -e

log_h1 "Installing Ruby"

RUBY_VERSION="3.3.0"

# install_brew "openssl@1.1"
install_brew "libyaml"
install_brew "rbenv"
install_brew "ruby-build"

export LDFLAGS="-L$(brew --prefix openssl@3)/lib -L$(brew --prefix libyaml)/lib"
export CPPFLAGS="-I$(brew --prefix openssl@3)/include -I$(brew --prefix libyaml)/include"
export PKG_CONFIG_PATH="$(brew --prefix openssl@3)/lib/pkgconfig:$(brew --prefix libyaml)/lib/pkgconfig"

install_ruby_if_needed() {
  if ! rbenv versions | grep -q "$RUBY_VERSION"; then
    echo "Installing Ruby $RUBY_VERSION..."
    RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3) --with-libyaml-dir=$(brew --prefix libyaml)" rbenv install "$RUBY_VERSION"
    rbenv global "$RUBY_VERSION"
    echo "Ruby $RUBY_VERSION installed and set as global default."
  else
    echo "Ruby $RUBY_VERSION is already installed."
    rbenv global "$RUBY_VERSION"
  fi
}

install_ruby_if_needed

# Install Bundler if not installed
if ! gem list bundler -i >/dev/null 2>&1; then
  echo "Installing Bundler..."
  gem install bundler
  rbenv rehash
else
  echo "Bundler is already installed."
fi

# Install kamal gems
INSTALL_GEMS=("kamal")

for gem in "${INSTALL_GEMS[@]}"; do
  if ! gem list "$gem" -i >/dev/null 2>&1; then
    echo "Installing gem: $gem..."
    gem install "$gem"
    rbenv rehash
  else
    echo "Gem '$gem' is already installed."
  fi
done
