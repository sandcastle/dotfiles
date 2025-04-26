#!/usr/bin/env bash
set -e && ( set -o pipefail; ) 2>/dev/null || true

log_h1 "Node & Tools"

run_command "Installing Node" mise use -g node@latest
run_command "Installing Yarn" mise use -g yarn@latest
run_command "Installing PNPM" mise use -g pnpm@latest
