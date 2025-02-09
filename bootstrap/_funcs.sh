#!/usr/bin/env zsh

print_heading() {
    local heading=$1
    echo ""  # Add blank line before heading
    echo "\033[1m${heading}\033[0m"  # Bold text using ANSI escape codes
}

program_exists() {
    local program=$1
    local app_name=$2  # Optional alternative app name
    
    # Check if command exists in PATH
    if command -v "$program" >/dev/null 2>&1; then
        echo "$program is already installed (found in PATH)"
        return 0
    fi
    
    # Check common application directories for macOS apps
    local check_app_name="${program%.app}.app"  # Default to program name
    if [ -n "$app_name" ]; then
        check_app_name="${app_name%.app}.app"  # Use alternative app name if provided
    fi
    
    if [ -d "/Applications/${check_app_name}" ] || [ -d "$HOME/Applications/${check_app_name}" ]; then
        echo "$program is already installed (found in Applications)"
        return 0
    fi
    
    return 1
}

# Function to install any brew package (auto-detects if it's a cask)
install_brew() {
    local package=$1
    local app_name=$2  # Optional alternative app name
    
    # First check if it exists anywhere on the system
    if program_exists "$package" "$app_name"; then
        echo "Note: $package appears to be installed outside of brew"
        return 0
    fi

    local is_cask=false
    local is_formula=false

    # More strict check using brew info
    if brew info --cask "$package" &>/dev/null; then
        is_cask=true
    elif brew info --formula "$package" &>/dev/null; then
        is_formula=true
    fi

    # Install based on package type
    if $is_cask; then
        if ! brew list --cask "$package" &>/dev/null; then
            echo "Installing cask $package..."
            brew install --cask "$package"
        else
            echo "Cask $package is already installed"
        fi
    elif $is_formula; then
        if ! brew list --formula "$package" &>/dev/null; then
            echo "Installing formula $package..."
            brew install "$package"
        else
            echo "Formula $package is already installed"
        fi
    else
        echo "Error: $package not found in brew (neither cask nor formula)"
        return 1
    fi
}