#!/usr/bin/env bash

# Environment
export LDFLAGS="-L$(brew --prefix openssl@3)/lib -L$(brew --prefix libyaml)/lib"
export CPPFLAGS="-I$(brew --prefix openssl@3)/include -I$(brew --prefix libyaml)/include"
export PKG_CONFIG_PATH="$(brew --prefix openssl@3)/lib/pkgconfig:$(brew --prefix libyaml)/lib/pkgconfig"

# Aliases
alias bx='bundle exec'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
