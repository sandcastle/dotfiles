#!/usr/bin/env zsh

# ==================================================================
# Node Virtual Machine
# ==================================================================


# Paths
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_BIN:$PATH"

# Yarn
export PATH="$PATH:`yarn global bin`"

# Link current version
source "$NVM_DIR/nvm.sh"
