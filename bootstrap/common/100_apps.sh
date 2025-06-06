#!/usr/bin/env bash

log_h1 "Installing common apps"

# core tools
install_package "neovim" -check nvim # Modern text editor
install_package "git"                # Version control system
install_package "gh"                 # GitHub CLI tool
install_package "fzf"                # Command-line fuzzy finder
install_package "ripgrep" -check rg  # Fast text search tool (grep alternative)
install_package "jq"                 # Command-line JSON processor
install_package "tree"               # Display directory structure as a tree
install_package "wget"               # Network file downloader
install_package "curl"               # Command-line tool for transferring data with URL syntax
install_package "bats"               # Bash Automated Testing System

# modern replacements
install_package "bat"          # Modern cat alternative with syntax highlighting
install_package "eza" -apt exa # Modern ls replacement with better defaults and colors
install_package "delta"        # Syntax-highlighting pager for git and diff output
install_package "zoxide"       # Smarter cd command that learns your most used directories
install_package "duf"          # Better disk usage/free utility with colorful graphs
install_package "hyperfine"    # Command-line benchmarking tool
install_package "pwgen"        # Password generator

# monitoring tools
install_package "cloc"               # Count lines of code in a project
install_package "httpie" -check http # User-friendly HTTP client
install_package "watch"              # Execute commands periodically and show output
install_package "htop"               # Interactive process viewer
install_package "ncdu"               # Disk usage analyzer with ncurses interface

# MISE - https://mise.jdx.dev/
run_command "Installing MISE" $(curl -s https://mise.run | MISE_QUIET=1 MISE_INSTALL_HELP=0 sh -s >/dev/null 2>&1)
