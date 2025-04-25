# Avoid sourcing more than once for a session
if [[ -n "${FUNCS_SOURCED}" ]]; then
  return
fi
FUNCS_SOURCED=1

# Get current directory, works in both source and execution contexts
if [[ -n "${BASH_SOURCE[0]}" ]]; then
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
elif [[ -n "$0" ]]; then
    SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
else 
    echo "Error: Cannot determine script location" >&2
    exit 1
fi

# Load the config file using absolute path
. "${SCRIPT_DIR}/_config.sh"

# Logging functions
# Usage: log_info "Information message" [true/false]
# Displays an information message with a blue arrow prefix
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example: ➜ Information message
log_info() {
    local message="$1"
    local newline=${2:-true}

    if [ "$newline" = true ]; then
        printf "\033[0;34m➜\033[0m %s\n" "$message"
    else
        printf "\033[0;34m➜\033[0m %s" "$message"
    fi
}

# Usage: log_success "Success message" [true/false]
# Displays a success message with a green checkmark prefix
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example: ✓ Success message
log_success() {
    local message="$1"
    local newline=${2:-true}

    if [ "$newline" = true ]; then
        printf "\033[0;32m✓\033[0m %s\n" "$message"
    else
        printf "\033[0;32m✓\033[0m %s" "$message"
    fi
}

# Usage: log_error "Error message" [true/false]
# Displays an error message with a red X prefix (outputs to stderr)
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example: ✗ Error message
log_error() {
    local message="$1"
    local newline=${2:-true}

    if [ "$newline" = true ]; then
        printf "\033[0;31m✗\033[0m %s\n" "$message" >&2
    else
        printf "\033[0;31m✗\033[0m %s" "$message" >&2
    fi
}

# Usage: log_warning "Warning message" [true/false]
# Displays a warning message with a yellow exclamation mark prefix
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example: ! Warning message
log_warning() {
    local message="$1"
    local newline=${2:-true}

    if [ "$newline" = true ]; then
        printf "\033[0;33m!\033[0m %s\n" "$message"
    else
        printf "\033[0;33m!\033[0m %s" "$message"
    fi
}

# Usage: log_finished "Process completed" [true/false] ["Next step 1" "Next step 2" ...]
# Indicates process completion with optional next steps displayed as a list
# The first argument is the main completion message
# Second optional argument controls whether to add newlines (defaults to true)
# All subsequent arguments are displayed as follow-up steps or considerations
# Output example:
# ✨ Process completed
#
#    → Next step 1
#    → Next step 2
#
log_finished() {
    local message="$1"
    local newline=true
    local args=()

    # Check if second argument is a boolean for newline control
    if [ $# -gt 1 ] && { [ "$2" = true ] || [ "$2" = false ]; }; then
        newline="$2"
        shift 2  # Remove message and newline flag
        args=("$@")  # Store remaining arguments
    else
        shift 1  # Remove only the message
        args=("$@")  # Store remaining arguments
    fi

    if [ "$newline" = true ]; then
        printf "\033[0;36m✨\033[0m\033[1m%s\033[0m\n" "$message"
    else
        printf "\033[0;36m✨\033[0m\033[1m%s\033[0m" "$message"
        return  # Early return if no newline desired (skipping next steps)
    fi

    # Check if there are additional arguments for next steps/considerations
    if [ ${#args[@]} -gt 0 ]; then
        echo ""

        # Iterate through each of the remaining arguments
        for item in "${args[@]}"; do
            printf "  \033[0;36m→\033[0m %s\n" "$item"
        done
    fi

    echo ""  # Add blank line after completed message for better readability
}

# Usage: run_with_progress "Message to display" [show_output] command [args...]
# Executes a command while showing a progress indicator
# First argument is the message to display during execution
# All remaining arguments form the command to be executed
# Returns the exit code of the executed command
# Captures and displays the command output below the progress message
# Cleans up all output when complete, leaving only a success message
# If the command fails, shows an error message and the last 20 lines of output
# Output example: ⠋ Message to display (with spinning animation)
#                 [command output appears here]
# When complete: ✓ Message to display
# When failed:   ✗ Message to display (failed)
#                [last 20 lines of command output]
run_with_progress() {
    local message=$1
    local show_output=true  # Default to showing output
    
    # Check if the second argument is a boolean for output control
    if [ $# -gt 1 ] && { [ "$2" = true ] || [ "$2" = false ]; }; then
        show_output="$2"
        shift 2  # Remove the message and show_output flag
    else
        shift 1  # Remove only the message
    fi

    # Create a temporary file to store command output
    local temp_file
    temp_file=$(mktemp)

    # Execute the command in the background, redirecting output to the temp file
    "$@" > "$temp_file" 2>&1 &
    local pid=$!

    # Show progress and output while the command is running
    show_progress "$message" $pid "$temp_file" "$show_output"

    # Wait for the command to finish and capture its exit code
    wait $pid
    local exit_code=$?

    # If the command failed, display an error and the last 20 lines of output
    if [ $exit_code -ne 0 ]; then
        log_error "${message} (failed)"
        echo ""
        echo "Last 20 lines of output:"
        echo "------------------------"
        tail -n 20 "$temp_file" | sed 's/^/    /'
        echo ""
    fi

    # Clean up temporary file
    rm -f "$temp_file"

    return $exit_code
}

# Usage: show_progress "Message to display" process_pid output_file [show_output]
# Internal function used by run_with_progress
# Displays an animated spinner next to the message while the process is running
# Shows the command output below the progress message, updating in real-time
# Cleans up all displayed output when the process completes
# Optional fourth parameter controls whether to display output (defaults to true)
# Output example: ⠙ Message to display (spinner cycles through ⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏)
#                 [command output appears here]
# When complete: ✓ Message to display
show_progress() {
    local message=$1
    local pid=$2
    local output_file=$3
    local show_output=${4:-true}  # Default to showing output
    local delay=0.2  # Increased delay for smoother animation
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    local prev_output=""
    local last_lines=""
    local lines_displayed=0
    local output_changed=false
    local first_run=true

    # Function to clear previously displayed output lines
    clear_previous_output() {
        if [ $lines_displayed -gt 0 ]; then
            # Move up 'lines_displayed' lines and clear to the end of screen
            printf "\033[%dA\033[J" "$lines_displayed"
            lines_displayed=0
        fi
    }

    while kill -0 $pid 2>/dev/null; do
        local current_char=${spinstr:$i:1}
        i=$(( (i+1) % ${#spinstr} ))

        # Print progress spinner and message
        printf "\r\033[0;34m%s\033[0m %s" "${current_char}" "${message}"

        # Check for new output (only if show_output is true)
        if [ "$show_output" = true ]; then
            output_changed=false
            if [ -f "$output_file" ]; then
                # Display up to 10 most recent lines from the file
                last_lines=$(tail -n 10 "$output_file" 2>/dev/null)

                # Only update display if output has changed or this is the first run
                if [ "$last_lines" != "$prev_output" ] || [ "$first_run" = true ]; then
                    output_changed=true
                    prev_output="$last_lines"
                    first_run=false
                fi
            fi

            # Only redraw if the output has changed
            if [ "$output_changed" = true ] && [ -n "$last_lines" ]; then
                # Clear previous output
                clear_previous_output

                # Count how many lines we're displaying
                lines_displayed=$(echo "$last_lines" | wc -l)

                # Print the output indented
                printf "\n%s" "$(echo "$last_lines" | sed 's/^/    /')"
            fi
        fi

        sleep $delay
    done

    # Clear spinner line and all output lines
    printf "\r\033[K"  # Clear the current line (spinner)
    clear_previous_output  # Clear all output lines

    # Call log_success with true for newline to ensure it appears on a new line
    log_success "${message}"
}

# Usage: log_h1 level "Heading text" [true/false]
# Wrapper around log_h1 to log_h4 functions
# First parameter is the heading level (1-4)
# Second parameter is the heading text
# Optional third parameter controls whether to add a newline (defaults to true)
# Examples:
#   log_h1 1 "Primary Heading"    # Calls log_h1
#   log_h1 2 "Secondary Heading"  # Calls log_h2
#   log_h1 3 "Tertiary Heading"   # Calls log_h3
#   log_h1 4 "Quaternary Heading" # Calls log_h4
log_h1() {
    local level="$1"
    local heading="$2"
    local newline=${3:-true}

    case "$level" in
        1) log_h1 "$heading" "$newline" ;;
        2) log_h2 "$heading" "$newline" ;;
        3) log_h3 "$heading" "$newline" ;;
        4) log_h4 "$heading" "$newline" ;;
        *) log_error "Invalid heading level: $level. Use 1-4." ;;
    esac
}

# Usage: log_h1 "Primary Heading" [true/false]
# Prints a large, primary heading with double lines above and below
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example:
#
# ═════════════════════════════════════
#   PRIMARY HEADING
# ═════════════════════════════════════
log_h1() {
    local heading="${1:-}"
    local newline=${2:-true}
    local line="═════════════════════════════════════"
    local uppercase_heading

    # Cross-platform uppercase conversion
    uppercase_heading=$(echo "$heading" | awk '{print toupper($0)}')

    echo
    printf "\033[1;34m%s\033[0m\n" "$line"
    printf "\033[1;34m%s\033[0m\n" "$uppercase_heading"
    printf "\033[1;34m%s\033[0m\n" "$line"

    if [ "$newline" = true ]; then
        echo
    fi
}

# Usage: log_h2 "Secondary Heading" [true/false]
# Prints a medium-sized secondary heading
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example:
#
# ❯❯ Secondary Heading
log_h2() {
    local heading="${1:-}"
    local newline=${2:-true}

    echo ""  # Add blank line before heading
    if [ "$newline" = true ]; then
        printf "\033[1;33m❯❯\033[0m \033[1m%s\033[0m\n" "$heading"
    else
        printf "\033[1;33m❯❯\033[0m \033[1m%s\033[0m" "$heading"
    fi
}

# Usage: log_h3 "Tertiary Heading" [true/false]
# Prints a smaller tertiary heading
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example:
#
# ❯ Tertiary Heading
log_h3() {
    local heading="${1:-}"
    local newline=${2:-true}

    echo ""  # Add blank line before heading
    if [ "$newline" = true ]; then
        printf "\033[1;33m❯\033[0m \033[1m%s\033[0m\n" "$heading"
    else
        printf "\033[1;33m❯\033[0m \033[1m%s\033[0m" "$heading"
    fi
}

# Usage: log_h4 "Quaternary Heading" [true/false]
# Prints a minimal quaternary heading with just bold text
# Optional second parameter controls whether to add a newline (defaults to true)
# Output example:
#
# Quaternary Heading
log_h4() {
    local heading="${1:-}"
    local newline=${2:-true}

    echo ""  # Add blank line before heading
    if [ "$newline" = true ]; then
        printf "\033[0;1m%s\033[0m\n" "$heading"
    else
        printf "\033[0;1m%s\033[0m" "$heading"
    fi
}

# Usage: program_exists "command_name"
# Checks if a program/command exists in the system PATH
# Returns true (0) if the command exists, false (1) otherwise
# Output example: No output, used in conditionals
# Example usage:
#   if program_exists "git"; then
#     echo "Git is installed"
#   fi
program_exists() {
    command -v "$1" >/dev/null 2>&1
}

# OS detection functions

# Usage: if is_macos; then ... fi
# Returns true (0) if the current system is macOS, false (1) otherwise
# Output example: No output, used in conditionals
# Example usage:
#   if is_macos; then
#     echo "This is running on macOS"
#   fi
is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

# Usage: if is_linux; then ... fi
# Returns true (0) if the current system is Linux, false (1) otherwise
# Output example: No output, used in conditionals
# Example usage:
#   if is_linux; then
#     echo "This is running on Linux"
#   fi
is_linux() {
    [[ "$(uname)" == "Linux" ]]
}

# Function to install any brew package (auto-detects if it's a cask)
install_brew() {
    run_with_progress "Installing $1" false _install_brew "$@"
}

# Function to install any brew package (auto-detects if it's a cask)
_install_brew() {
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

# Usage: check_system
# Checks if the system meets minimum requirements for memory and disk space
# Displays warnings if the system does not meet the recommended specifications
# Output example: 
#   ! Low memory detected: 6GB (recommended: 8GB)
#   ! Low disk space: 15GB available (recommended: 20GB)
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

# Usage: backup_file "/path/to/file"
# Creates a backup of the specified file in the backup directory
# Will only attempt to backup if the file exists
# Output example: ➜ Backing up /path/to/file to /path/to/backup/file
backup_file() {
    local file=$1
    if [[ -e "$file" ]]; then
        local backup="$BACKUP_DIR/$(basename "$file")"
        log_info "Backing up $file to $backup"
        mv "$file" "$backup"
    fi
}

ensure_package_managers_updated() {
    run_with_progress "Updating package managers" false _ensure_package_managers_updated
}

_ensure_package_managers_updated() {
  if command -v brew >/dev/null 2>&1; then
    brew update
  fi
  if command -v snap >/dev/null 2>&1; then
    sudo snap refresh
  fi
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y
  fi
  if command -v dnf >/dev/null 2>&1; then
    sudo dnf update -y
  fi
  if command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --noconfirm
  fi
}

# Usage: install_package "package_name"
# Installs a package using the system's available package manager
# Supports Homebrew, apt-get, and dnf
# Returns 0 on success, 1 on failure
# Output example: 
#   ➜ Installing git...
#   ✓ Package git is already installed
install_package() {
    run_with_progress "Installing $1" false _install_package "$@"
}

_install_package() {
  local package_name="$1"

  # Homebrew handles updates gracefully during install.
  if command -v brew >/dev/null 2>&1; then
    if brew install "$package_name"; then
      return 0
    fi
  fi

  # Snap: try refresh first (updates if installed), then install.
  if command -v snap >/dev/null 2>&1; then
    if sudo snap refresh "$package_name"; then
      return 0 # Already installed and up-to-date
    else
      # If refresh failed (maybe not installed), try installing
      if sudo snap install "$package_name"; then
        return 0 # Installed successfully
      fi
    fi
  fi

  # apt-get install -y handles both install and update.
  if command -v apt-get >/dev/null 2>&1; then
    if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$package_name"; then
      return 0
    fi
  fi

  # dnf install -y handles both install and update.
  if command -v dnf >/dev/null 2>&1; then
    if sudo dnf install -y "$package_name"; then
      return 0
    fi
  fi

  # pacman -S --noconfirm handles both install and update.
  if command -v pacman >/dev/null; then
    if sudo pacman -S --noconfirm "$package_name"; then
      return 0
    fi
  fi

  log_error "No supported package manager found for installing ${package_name}"
  return 1
}

# Usage: setup_vscode
# Sets up Visual Studio Code CLI tools and installs essential extensions
# Creates a symbolic link for the 'code' command if it doesn't exist
# Output example:
#   ➜ Setting up VS Code CLI tools
#   ✓ VS Code CLI tools installed successfully
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

# Usage: error_handler $? $LINENO ${BASH_LINENO[0]} "$BASH_COMMAND" "${FUNCNAME[*]}"
# Handles errors in script execution and provides detailed debug information
# Should be called from a trap or directly after command execution
# Parameters: exit code, line number, bash lineno, last command, function stack
# Output example:
#   Error occurred in:
#     - Command: some_command arg1 arg2
#     - Line: 42
#     - Function: main setup_environment
#   Exit code: 1
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

# Usage: prompt_user "Enter your name" USERNAME "default_value"
# Prompts the user for input with an optional default value
# First parameter is the prompt text
# Second parameter is the variable name to store the result in
# Third parameter (optional) is the default value if user provides no input
# Output example: Enter your name [default_value]: 
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
        printf -v "$variable" "%s" "$value"
    fi
}