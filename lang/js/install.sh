#!/usr/bin/env bash
set -e && ( set -o pipefail; ) 2>/dev/null || true

log_h1 "Node & Tools"

run_with_progress "Installing Node" true mise use -g node@latest
run_with_progress "Installing Yarn" true mise use -g yarn@latest
run_with_progress "Installing PNPM" true mise use -g pnpm@latest
