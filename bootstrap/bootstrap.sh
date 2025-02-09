#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

# Source common utilities and functions
source "$(dirname "$0")/tools.sh"

# Run OS-specific setup
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$(dirname "$0")/mac_os.sh"
elif [[ "$OS_TYPE" == "linux" ]]; then
    source "$(dirname "$0")/linux.sh"
fi

# Run common setup steps
source "$(dirname "$0")/common.sh"

# Final checks
source "$(dirname "$0")/700_final_checks.sh
