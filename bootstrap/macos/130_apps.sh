#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

print_heading "Installing macOS applications"

# general
log_info "Installing general utilities"
# install_brew "iterm2" "iTerm"
install_brew "openssl"
install_brew "htop-osx"
install_brew "httpie"
install_brew "cardhop"
install_brew "fantastical"
install_brew "bartender"

# security
log_info "Installing security applications"
install_brew "1password-cli"
install_brew "cloudflare-warp"

# media
log_info "Installing media applications"
install_brew "vlc"
install_brew "plex-media-server"
install_brew "sabnzbd"
install_brew "spotify"
install_brew "handbrake"

# browsers
log_info "Installing browsers"
install_brew "google-chrome" "Google Chrome"

defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# cloud/kube
log_info "Installing cloud and kubernetes tools"
install_brew "kubernetes-cli"
install_brew "kubernetes-helm"
install_brew "kubectx"
install_brew "skaffold"
install_brew "google-cloud-sdk"
log_info "Updating gcloud components"
gcloud components update --quiet
gcloud components install gke-gcloud-auth-plugin --quiet
gcloud components install gsutil --quiet
install_brew "awscli"

# tools
log_info "Installing development tools"
install_brew "jetbrains-toolbox"
install_brew "visual-studio-code" "Visual Studio Code"
install_brew "terraform"
install_brew "docker"
install_brew "docker-compose"
install_brew "ngrok"

setup_vscode

# design
log_info "Installing design tools"
install_brew "cleanshot"
install_brew "pixelsnap"
install_brew "figma"
install_brew "drawio"
install_brew "colour-contrast-analyser"
install_brew "losslesscut"
install_brew "imageoptim"

# gaming
log_info "Installing gaming applications" 
install_brew "discord"

# git
log_info "Installing git tools"
install_brew "gitkraken"
install_brew "tig"
install_brew "diff-so-fancy"


log_success "Application configuration complete"
