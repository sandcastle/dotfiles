#!/usr/bin/env zsh

# ==================================================================
# Commandline Tools
# ==================================================================

# Initialize zoxide (smarter cd command)
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
