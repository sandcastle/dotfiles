#!/usr/bin/env bash

# ==================================================================
# NVM
# ==================================================================

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
export PATH="$NVM_BIN:$PATH"

# ==================================================================
# PNPM
# ==================================================================

export PNPM_HOME="/Users/glenn/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ==================================================================
# Yarn
# ==================================================================

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
