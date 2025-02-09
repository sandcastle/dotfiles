#!/bin/bash
# Core development tools

source "$(dirname "$0")/_funcs.sh"

print_heading "Installing core development tools"

# Install tools in parallel
tools=(
    "git"
    "gh"
    "fzf"
    "ripgrep"
    "fd"
    "jq"
    "yq"
    "tree"
    "wget"
    "curl"
)

# Create a temp file for logging
TEMP_LOG=$(mktemp)

# Install tools in parallel with a maximum of 4 concurrent jobs
for tool in "${tools[@]}"; do
    (install_brew "$tool" >> "$TEMP_LOG" 2>&1) &
    
    # Limit concurrent jobs
    if [[ $(jobs -r -p | wc -l) -ge 4 ]]; then
        wait -n
    fi
done

# Wait for all background jobs to finish
wait

# Show results
cat "$TEMP_LOG"
rm "$TEMP_LOG"

# Modern replacements
install_brew "bat"            # Better cat
install_brew "exa"            # Better ls
install_brew "delta"          # Better git diff
install_brew "zoxide"         # Better cd
install_brew "duf"            # Better df
install_brew "bottom"         # Better top

# Monitoring and utilities
install_brew "cloc"           # For 'lines' alias
install_brew "httpie"         # For HTTP client aliases
install_brew "trash"          # For safe rm
install_brew "watch"          # For monitoring commands
install_brew "htop"           # For process monitoring
install_brew "ncdu"           # For disk usage analysis 