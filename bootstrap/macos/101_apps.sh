#!/usr/bin/env bash

log_h1 "Installing macOS apps"

# general
log_h4 "Installing general utilities"
install_brew "iterm2" "iTerm"
install_brew "openssl"
install_brew "htop-osx"
install_brew "httpie"
install_brew "cardhop"
install_brew "fantastical"
install_brew "bartender"

# ai
install_brew "claude"

# security
log_h4 "Installing security applications"
install_brew "1password-cli"

# media
log_h4 "Installing media applications"
install_brew "vlc"
install_brew "plex-media-server"
install_brew "sabnzbd"
install_brew "spotify"
install_brew "handbrake"

# browsers
log_h4 "Installing browsers"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# cloud/kube
log_h4 "Installing cloud and kubernetes tools"
install_brew "kubernetes-cli"
install_brew "kubernetes-helm"
install_brew "kubectx"
install_brew "google-cloud-sdk"
install_brew "awscli"
install_brew "terraform"
install_brew "terraformer"
install_brew "terragrunt"

log_h4 "Updating gcloud components"
run_command "Updating gcloud components" gcloud components update --quiet
run_command "Installing gke-gcloud-auth-plugin" gcloud components install gke-gcloud-auth-plugin --quiet
run_command "Installing gsutil" gcloud components install gsutil --quiet

# Cloudflare
log_h4 "Installing Cloudflare tools"
install_brew "cloudflare-warp"
install_brew "cloudflared"
run_command "Installing wrangler" npm install -g wrangler

# Docker
log_h4 "Installing Docker tools"
install_brew "docker"
install_brew "docker-compose"
install_brew "ngrok"

# modern tools
log_h4 "Installing modern tools"
install_brew "sd"       # Intuitive find & replace CLI (sed alternative)
install_brew "yq"       # YAML processor (like jq but for YAML)
install_brew "gping"    # Ping with a graphical display
install_brew "dust"     # More intuitive version of du with colored output
install_brew "bottom"   # Graphical system/process monitor, alternative to top/htop
install_brew "procs"    # Modern replacement for ps with additional features
install_brew "tealdeer" # Fast tldr client (simplified, example-based man pages)
install_brew "moar"     # More intuitive pager for git and diff output
install_brew "trash"    # Move files to trash instead of permanent deletion
install_brew "choose"   # cut/awk alternative with a more intuitive interface

# IDE
log_h4 "Installing IDEs"
install_brew "jetbrains-toolbox"
install_brew "cursor"

run_command "Setting up VS Code CLI tools" setup_vscode

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
