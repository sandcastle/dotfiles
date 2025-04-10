#!/usr/bin/env sh

# ==================================================================
# Commandline Tools
# ==================================================================

# Initialize zoxide (smarter cd command)
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
