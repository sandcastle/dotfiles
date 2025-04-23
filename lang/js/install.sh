#!/usr/bin/env bash

set -e

log_h1 "Installing Node, Yarn, PNPM"

install_brew "nvm"
install_brew "yarn"
install_brew "pnpm"
