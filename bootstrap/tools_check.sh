#!/bin/bash

# Function to check if a command exists
check_command() {
    local cmd=$1
    local package=${2:-$1}
    if ! command -v "$cmd" &>/dev/null; then
        echo "Warning: $cmd not found. Install with: brew install $package"
        return 1
    fi
    return 0
}

# Check all tools required by aliases and functions
check_command "rg" "ripgrep"      # for grep alias
check_command "fd"                # for find alias
check_command "bat"               # for cat alias
check_command "exa"               # for ls aliases
check_command "cloc"              # for lines alias
check_command "http"              # for HTTP aliases
check_command "trash"             # for rm alias
check_command "htop"              # for top aliases
check_command "python3"           # for http-serve alias
check_command "jq"                # for JSON processing
check_command "docker"            # for docker aliases
check_command "git"               # for git aliases
check_command "code"              # for VSCode alias 