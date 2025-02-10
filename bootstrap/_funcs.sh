#!/usr/bin/env bash

# Load configuration
source "$(dirname "${BASH_SOURCE[0]}")/_config.sh"

# Logging functions
log_info() {
    printf "\033[0;34m➜\033[0m %s\n" "$1"
}

log_success() {
    printf "\033[0;32m✓\033[0m %s\n" "$1"
}

log_error() {
    printf "\033[0;31m✗\033[0m %s\n" "$1" >&2
}

log_warning() {
    printf "\033[0;33m!\033[0m %s\n" "$1"
}

# Progress indicator
show_progress() {
    local message=$1
    local pid=$2
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf "\r\033[0;34m%s\033[0m %s" "${spinstr}" "${message}"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
    done
    printf "\r\033[0;32m✓\033[0m %s\n" "${message}"
}

print_heading() {
    local heading=$1
    echo ""  # Add blank line before heading
    echo -e "\033[1m==> $heading\033[0m"
}

program_exists() {
    command -v "$1" >/dev/null 2>&1
}

# OS detection
is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

is_linux() {
    [[ "$(uname)" == "Linux" ]]
}

# Function to install any brew package (auto-detects if it's a cask)
install_brew() {
    local package=$1
    local name=${2:-$1}
    local is_cask=${3:-""}
    
    log_info "Installing $name..."
    
    # Check if already installed
    if program_exists "$name"; then
        log_success "$name is already installed"
        return 0
    fi
    
    # Check for macOS applications and Homebrew packages
    if is_macos; then
        # Check for .app bundles
        if [ -d "/Applications/${name}.app" ] || [ -d "$HOME/Applications/${name}.app" ]; then
            log_success "$name is already installed"
            return 0
        fi
        
        # Check if already installed via Homebrew
        if [[ "$is_cask" == "--cask" ]]; then
            if brew list --cask "$package" &>/dev/null; then
                log_success "$name is already installed via Homebrew Cask"
                return 0
            fi
        else
            if brew list "$package" &>/dev/null; then
                log_success "$name is already installed via Homebrew"
                return 0
            fi
        fi
    fi
    
    # Install with progress indicator
    if [[ "$is_cask" == "--cask" ]]; then
        (brew install --cask "$package" > /tmp/brew.log 2>&1) &
    else
        (brew install "$package" > /tmp/brew.log 2>&1) &
    fi
    
    show_progress "Installing $name" $!
    
    # Verify installation
    if [[ "$is_cask" == "--cask" ]]; then
        # For casks, check if the application exists in /Applications or ~/Applications
        if [ ! -d "/Applications/${name}.app" ] && [ ! -d "$HOME/Applications/${name}.app" ]; then
            if ! brew list --cask "$package" &>/dev/null; then
                log_error "Failed to install $name"
                cat /tmp/brew.log
                return 1
            fi
        fi
    else
        # For regular brew packages, check if the command exists
        if ! program_exists "$name"; then
            if ! brew list "$package" &>/dev/null; then
                log_error "Failed to install $name"
                cat /tmp/brew.log
                return 1
            fi
        fi
    fi
    
    log_success "$name installed successfully"
}

# Check system requirements
check_system() {
    local min_memory=8 # GB
    local min_disk=20  # GB
    
    # Check memory
    local memory=$(sysctl hw.memsize | awk '{print $2 / 1024^3}')
    if (( $(echo "$memory < $min_memory" | bc -l) )); then
        log_warning "Low memory detected: ${memory}GB (recommended: ${min_memory}GB)"
    fi
    
    # Check disk space
    local disk=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//')
    if (( $(echo "$disk < $min_disk" | bc -l) )); then
        log_warning "Low disk space: ${disk}GB available (recommended: ${min_disk}GB)"
    fi
}

# Backup function
backup_file() {
    local file=$1
    if [[ -e "$file" ]]; then
        local backup="$BACKUP_DIR/$(basename "$file")"
        log_info "Backing up $file to $backup"
        mv "$file" "$backup"
    fi
}

# Install packages based on OS and package manager
install_package() {
    local package_name="$1"
    echo "➜ Installing ${package_name}..."
    
    if command -v brew >/dev/null 2>&1; then
        # For Homebrew
        if brew list "$package_name" >/dev/null 2>&1; then
            echo "✓ Package ${package_name} is already installed"
            return 0
        fi
        brew install "$package_name" || {
            # Only fail if it's a real error, not just "already installed"
            if [[ $? -ne 0 && ! "$PIPESTATUS" =~ "already installed" ]]; then
                echo "✗ Failed to install ${package_name}"
                return 1
            fi
            return 0
        }
    elif command -v apt-get >/dev/null 2>&1; then
        # For apt-based systems
        sudo apt-get install -y "$package_name"
    elif command -v dnf >/dev/null 2>&1; then
        # For dnf-based systems
        sudo dnf install -y "$package_name"
    else
        echo "✗ No supported package manager found"
        return 1
    fi
}

# Install multiple packages in parallel (macOS) or serial (Linux)
install_packages() {
    local packages=("$@")
    
    if is_macos; then
        # Create a temp file for logging
        TEMP_LOG=$(mktemp)

        # Install packages in parallel with a maximum of 4 concurrent jobs
        local pids=()
        for package in "${packages[@]}"; do
            (install_brew "$package" >> "$TEMP_LOG" 2>&1) &
            pids+=($!)
            
            # Limit concurrent jobs
            if [[ ${#pids[@]} -ge 4 ]]; then
                wait "${pids[0]}"
                pids=("${pids[@]:1}")
            fi
        done

        # Wait for remaining jobs
        for pid in "${pids[@]}"; do
            wait "$pid"
        done
        
        cat "$TEMP_LOG"
        rm "$TEMP_LOG"
    elif is_linux; then
        if command -v apt-get >/dev/null; then
            sudo apt-get install -y "${packages[@]}"
        elif command -v dnf >/dev/null; then
            sudo dnf install -y "${packages[@]}"
        elif command -v pacman >/dev/null; then
            sudo pacman -S --noconfirm "${packages[@]}"
        fi
    fi
}

setup_vscode() {
    if [ -d "/Applications/Visual Studio Code.app" ]; then
        log_info "Setting up VS Code CLI tools"
        # Install command line tools via VS Code
        "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" --install-extension ms-vscode.cpptools

        # Create symbolic link if it doesn't exist
        if [ ! -f "/usr/local/bin/code" ]; then
            sudo ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "/usr/local/bin/code"
        fi
        
        log_success "VS Code CLI tools installed successfully"
    else
        log_warning "VS Code not found. Please install it first."
    fi
}

# Error handling
error_handler() {
    local exit_code=$1
    local line_no=$2
    local bash_lineno=$3
    local last_command=$4
    local func_stack=$5

    echo "Error occurred in:"
    echo "  - Command: $last_command"
    echo "  - Line: $line_no"
    echo "  - Function: $func_stack"
    echo "Exit code: $exit_code"
}

# User input helper
prompt_user() {
    local prompt=$1
    local variable=$2
    local default=${3:-""}
    
    # Use indirect reference with default empty string if variable doesn't exist
    local current_value=""
    if [ -n "${!variable+x}" ]; then
        current_value="${!variable}"
    fi
    
    if [[ -z "$current_value" ]]; then
        read -rp "$prompt [${default}]: " value
        value=${value:-$default}
        eval "$variable=\"$value\""
    fi
}