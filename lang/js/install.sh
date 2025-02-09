#!/usr/bin/env zsh

set -e
cd "$(dirname "$0")/../.."

source "./bootstrap/_funcs.sh"

print_heading "⏲️ Installing Node, Yarn, PNPM, Bun"

install_brew "nvm"
install_brew "yarn"
install_brew "pnpm"

#bun
curl -fsSL https://bun.sh/install | bash
