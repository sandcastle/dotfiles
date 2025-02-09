#!/bin/bash
# Development environments

source "$(dirname "$0")/_funcs.sh"

print_heading "Setting up development environments"

# Run language-specific installers
source "$DOT_FILES/lang/js/install.sh"
source "$DOT_FILES/lang/python/install.sh"
source "$DOT_FILES/lang/ruby/install.sh"
source "$DOT_FILES/lang/dotnet/install.sh" 