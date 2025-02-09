#!/usr/bin/env bash
# Configuration options for installation

# Computer name
COMPUTER_NAME=${COMPUTER_NAME:-""}

# Git configuration
GIT_NAME=${GIT_NAME:-""}
GIT_EMAIL=${GIT_EMAIL:-""}

# Development paths
DEV_PATH="$HOME/Developer"
WORK_PATH="$DEV_PATH/work"
PERSONAL_PATH="$DEV_PATH/personal"

# Feature flags
INSTALL_WORK_TOOLS=${INSTALL_WORK_TOOLS:-true}
INSTALL_PERSONAL_TOOLS=${INSTALL_PERSONAL_TOOLS:-true}

# Package selections
INSTALL_NODEJS=${INSTALL_NODEJS:-true}
INSTALL_PYTHON=${INSTALL_PYTHON:-true}
INSTALL_RUBY=${INSTALL_RUBY:-true}
INSTALL_GO=${INSTALL_GO:-true}
INSTALL_DOTNET=${INSTALL_DOTNET:-true}

# Cloud tools
INSTALL_AWS=${INSTALL_AWS:-true}
INSTALL_GCP=${INSTALL_GCP:-true} 