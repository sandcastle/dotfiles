#!/usr/bin/env bash
set -e && (set -o pipefail) 2>/dev/null || true

log_h1 "Ruby & Tools"

run_command "Installing Ruby" mise use -g ruby@latest

source "$DOTFILES/lang/ruby/check.sh"
