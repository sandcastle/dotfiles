#!/usr/bin/env bash
set -e && ( set -o pipefail; ) 2>/dev/null || true

log_h1 "Go & Tools"

run_command "Installing Go" mise use -g go@latest
