#!/usr/bin/env zsh

set -e
cd "$(dirname "$0")/../.."

source "./bootstrap/_funcs.sh"

log_h1 "Installing Node, Yarn, PNPM"

install_brew "nvm"
install_brew "yarn"
install_brew "pnpm"
