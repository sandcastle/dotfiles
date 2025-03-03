#!/usr/bin/env zsh

set -e
cd "$(dirname "$0")/../.."

source "./bootstrap/_funcs.sh"

log_h1 "⏲️ Installing Python"

install_brew "python3"

# Install pip

curl -LsSf https://astral.sh/uv/install.sh | sh

