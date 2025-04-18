#!/usr/bin/env sh

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

log_h1 "Installing common tools"

# core tools
install_package "git"        # Version control system
install_package "gh"         # GitHub CLI tool
install_package "fzf"        # Command-line fuzzy finder
install_package "ripgrep"    # Fast text search tool (grep alternative)
install_package "fd"         # Simple, fast alternative to find
install_package "jq"         # Command-line JSON processor
install_package "yq"         # YAML processor (like jq but for YAML)
install_package "tree"       # Display directory structure as a tree
install_package "wget"       # Network file downloader
install_package "curl"       # Command-line tool for transferring data with URL syntax
install_package "bats"       # Bash Automated Testing System

# modern replacements
install_package "bat"        # Modern cat alternative with syntax highlighting
install_package "eza"        # Modern ls replacement with better defaults and colors
install_package "delta"      # Syntax-highlighting pager for git and diff output
install_package "zoxide"     # Smarter cd command that learns your most used directories
install_package "duf"        # Better disk usage/free utility with colorful graphs
install_package "bottom"     # Graphical system/process monitor, alternative to top/htop
install_package "dust"       # More intuitive version of du with colored output
install_package "procs"      # Modern replacement for ps with additional features
install_package "sd"         # Intuitive find & replace CLI (sed alternative)
install_package "choose"     # cut/awk alternative with a more intuitive interface
install_package "xh"         # Friendly HTTP tool, alternative to curl/httpie
install_package "tealdeer"   # Fast tldr client (simplified, example-based man pages)
install_package "gping"      # Ping with a graphical display
install_package "hyperfine"  # Command-line benchmarking tool
install_package "moar"       # More intuitive pager for git and diff output
install_package "pwgen"      # Password generator

# monitoring tools
install_package "cloc"       # Count lines of code in a project
install_package "httpie"     # User-friendly HTTP client
install_package "trash"      # Move files to trash instead of permanent deletion
install_package "watch"      # Execute commands periodically and show output
install_package "htop"       # Interactive process viewer
install_package "ncdu"       # Disk usage analyzer with ncurses interface
