#!/usr/bin/env zsh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/glenn/.bun/_bun" ] && source "/Users/glenn/.bun/_bun"

# pnpm
export PNPM_HOME="/Users/glenn/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
