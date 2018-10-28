#!/usr/bin/env zsh

# ==================================================================
# Node
# ==================================================================

# nvm
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_BIN:$PATH"
source "$NVM_DIR/nvm.sh"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
