#!/usr/bin/env bash
set -e && (set -o pipefail) 2>/dev/null || true

# Get current directory, works in both source and execution contexts
if [[ -n "${BASH_SOURCE[0]}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [[ -n "$0" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
else
  echo "Error: Cannot determine script location" >&2
  exit 1
fi

. "$SCRIPT_DIR/_funcs.sh"

install_brew "1password"
install_brew "zoom"
install_brew "slack"
install_brew "google-chrome" "Google Chrome"
install_brew "visual-studio-code" "Visual Studio Code"
