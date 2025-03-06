#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

log_h1 "Installing macOS applications"

# general
log_h4 "Installing general utilities"
install_brew "iterm2" "iTerm"
install_brew "openssl"
install_brew "htop-osx"
install_brew "httpie"
install_brew "cardhop"
install_brew "fantastical"
install_brew "bartender"

# security
log_h4 "Installing security applications"
install_brew "1password-cli"
install_brew "cloudflare-warp"

# media
log_h4 "Installing media applications"
install_brew "vlc"
install_brew "plex-media-server"
install_brew "sabnzbd"
install_brew "spotify"
install_brew "handbrake"

# browsers
log_h4 "Installing browsers"
install_brew "google-chrome" "Google Chrome"

defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# cloud/kube
log_h4 "Installing cloud and kubernetes tools"
install_brew "kubernetes-cli"
install_brew "kubernetes-helm"
install_brew "kubectx"
install_brew "skaffold"
install_brew "google-cloud-sdk"

log_h4 "Updating gcloud components"
run_with_progress "Updating gcloud components" true gcloud components update --quiet
run_with_progress "Installing gke-gcloud-auth-plugin" true gcloud components install gke-gcloud-auth-plugin --quiet
run_with_progress "Installing gsutil" true gcloud components install gsutil --quiet
install_brew "awscli"
run_with_progress "Installing wrangler" true npm install -g wrangler

# tools
log_h4 "Installing development tools"
install_brew "jetbrains-toolbox"
install_brew "visual-studio-code" "Visual Studio Code"
install_brew "terraform"
install_brew "docker"
install_brew "docker-compose"
install_brew "ngrok"
install_brew "cursor"

run_with_progress "Setting up VS Code CLI tools" true setup_vscode

# design
log_h4 "Installing design tools"
install_brew "cleanshot"
install_brew "pixelsnap"
install_brew "figma"
install_brew "drawio"
install_brew "colour-contrast-analyser"
install_brew "losslesscut"
install_brew "imageoptim"

# gaming
log_h4 "Installing gaming applications" 
install_brew "discord"

# git
log_h4 "Installing git tools"
install_brew "gitkraken"
install_brew "tig"

log_success "Application configuration complete"
