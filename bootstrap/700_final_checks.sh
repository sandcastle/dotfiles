#!/usr/bin/env bash
# Final checks and verifications

source "$(dirname "$0")/_funcs.sh"

print_heading "Running final checks"

# Run tools check
source "$(dirname "$0")/tools_check.sh"

# Verify shell setup
if [[ $SHELL != "/bin/zsh" ]]; then
    echo "Warning: ZSH is not set as default shell"
fi

# Check for essential tools
essential_tools=(
    "git"
    "code"
    "docker"
    "node"
    "python3"
)

for tool in "${essential_tools[@]}"; do
    if ! program_exists "$tool"; then
        echo "Warning: $tool is not installed or not in PATH"
    fi
done

print_heading "Installation complete!"
echo "Please restart your terminal to apply all changes." 