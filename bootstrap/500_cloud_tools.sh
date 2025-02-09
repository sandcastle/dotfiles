#!/bin/bash
# Cloud and container tools

source "$(dirname "$0")/_funcs.sh"

print_heading "Installing cloud and container tools"

# Container tools
install_brew "kubectl"
install_brew "helm"
install_brew "k9s"

# Cloud CLIs
install_brew "awscli"
install_brew "google-cloud-sdk"

# Infrastructure as Code
install_brew "terraform" 