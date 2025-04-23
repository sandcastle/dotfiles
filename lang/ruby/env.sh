#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific settings
  export LDFLAGS="-L$(brew --prefix openssl@3)/lib -L$(brew --prefix libyaml)/lib"
  export CPPFLAGS="-I$(brew --prefix openssl@3)/include -I$(brew --prefix libyaml)/include"
  export PKG_CONFIG_PATH="$(brew --prefix openssl@3)/lib/pkgconfig:$(brew --prefix libyaml)/lib/pkgconfig"
elif [[ "$OSTYPE" == "linux"* ]]; then
  # Linux specific settings - typically these paths are standard or empty
  # Override as needed for your Linux distribution
  if command -v pkg-config >/dev/null 2>&1; then
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig"
  fi
fi

# Aliases (cross-platform)
alias bx='bundle exec'

# Add RVM to PATH for scripting if it exists
if [ -d "$HOME/.rvm/bin" ]; then
  export PATH="$PATH:$HOME/.rvm/bin"
fi
