#!/usr/bin/env bash

( set -o pipefail; ) 2>/dev/null || set -e;

text() {
  local format=""
  local reset="\033[0m"
  
  # Process all style arguments
  while [[ $# -gt 0 && "$1" =~ ^[a-z]+$ ]]; do
    case "$1" in
      bold) format="${format}\033[1m" ;;
      red) format="${format}\033[31m" ;;
      green) format="${format}\033[32m" ;;
      yellow) format="${format}\033[33m" ;;
      blue) format="${format}\033[34m" ;;
      magenta) format="${format}\033[35m" ;;
      cyan) format="${format}\033[36m" ;;
      *) break ;;
    esac
    shift
  done
  
  if [ -z "$format" ]; then
    format=$reset
  fi

  printf "%b%s%b" "${format}" "$*" "${reset}"
}

# Basic error handler without complex Bash-specific variables
error_handler() {
  echo "Error occurred at line $1"
  exit 1
}

trap 'error_handler $LINENO' ERR

# Initial setup
echo "$(text cyan    " _____        _    __ _ _            ")"
echo "$(text magenta "|  __ \      | |  / _(_) |           ")"
echo "$(text blue    "| |  | | ___ | |_| |_ _| | ___  ___  ")"
echo "$(text yellow  "| |  | |/ _ \| __| _| | |/ _ \/ __|  ")"
echo "$(text green   "| |__| | (_) | |_| | | | |  __/\__ \ ")"
echo "$(text red     "|_____/ \___/ \__|_| |_|_|\___||___/ ")"
echo ""
echo "$(text bold "$(text yellow "Welcome to the dotfiles installer!")")"
echo "→ This will set up your system with a complete development environment."
echo "→ You can cancel at any time by pressing CTRL+C"
echo

# Detect OS
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then
  # macOS specific
  COMPUTER_NAME_DEFAULT="$(scutil --get ComputerName 2>/dev/null || hostname)"
else
  # Linux/other OS
  COMPUTER_NAME_DEFAULT="$(hostname)"
fi

prompt_user() {
  local prompt=$1
  local variable=$2
  local default=${3:-""}
  local current_value=""
  eval "current_value=\"\${$variable:-}\""
  
  if [ -z "$current_value" ]; then
      # Print the prompt
      printf "%s [%s]: " "$prompt" "$default"
      
      # Check if stdin is a terminal
      if [ -t 0 ]; then
          # Interactive mode
          read -r value
      else
          # Non-interactive mode (being piped)
          value=""
          echo ""  # Add a newline for better formatting
      fi
      
      value=${value:-$default}
      eval "$variable=\"\$value\""
      
      # If in non-interactive mode, show what was selected
      if [ ! -t 0 ]; then
          echo "Using default: $value"
      fi
  fi
}

prompt_user "Enter dotfiles directory" DOTFILES "${DOTFILES:-$HOME/.dotfiles}"
prompt_user "Enter your computer name" COMPUTER_NAME "$COMPUTER_NAME_DEFAULT"
prompt_user "Enter your Git name" GIT_NAME "$(git config --global user.name 2>/dev/null || echo "Your Name")"
prompt_user "Enter your Git email" GIT_EMAIL "$(git config --global user.email 2>/dev/null || echo "your.email@example.com")"
echo

# Export for use in other scripts
export DOTFILES COMPUTER_NAME GIT_NAME GIT_EMAIL OS

# Create backup
export BACKUP_DIR="$HOME/.backup/dotfiles/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Repository setup
mkdir -p "$DOTFILES"
if [ -d "$DOTFILES/.git" ]; then
    echo "Updating existing dotfiles repository..."
    cd "$DOTFILES"
    git pull --depth 1
else
    echo "Cloning dotfiles repository..."
    # If we're in the repo already, move to a temp dir to prevent conflicts
    if [ -f "$DOTFILES/install.sh" ] && [ ! -d "$DOTFILES/.git" ]; then
        TMP_DIR=$(mktemp -d)
        mv "$DOTFILES"/* "$TMP_DIR/" 2>/dev/null || true
        mv "$DOTFILES"/.[!.]* "$TMP_DIR/" 2>/dev/null || true
    fi
    git clone --depth 1 https://github.com/sandcastle/dotfiles.git "$DOTFILES"
    rm -rf "$TMP_DIR"
fi

# Symlink files
chmod +x "$DOTFILES/install-symlink.sh"
if ! "$DOTFILES/install-symlink.sh"; then
    echo "Error running symlink setup"
    exit 1
fi

# Bootstrap the system
chmod +x "$DOTFILES/bootstrap/bootstrap.sh"
if ! "$DOTFILES/bootstrap/bootstrap.sh"; then
    echo "Error running bootstrap"
    exit 1
fi

# Final message
echo "✨ $(text cyan "Installation complete!") ✨"
echo "A few things to do:"
echo " 1. Check the $(text yellow "README.md") for additional customization options"
echo " 2. Run: $(text yellow "aliases") to review available aliases to save time"
echo " 3. Have fun!"
echo "Enjoy your new setup! "

exec zsh -l
