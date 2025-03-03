#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../_funcs.sh"

log_h1 "Configuring developer settings"

# Xcode command line tools check/install
if ! xcode-select -p &>/dev/null; then
    log_info "Installing Xcode Command Line Tools..."
    xcode-select --install
    log_success "Xcode Command Line Tools installed"
else
    log_success "Xcode Command Line Tools already installed"
fi

# Setup SSH key & link to Github
pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa
echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'

# languages
sh ./lang/js/install.sh
sh ./lang/dotnet/install.sh
sh ./lang/python/install.sh

# languages
log_info "Installing programming languages"
install_brew "java"
install_brew "powershell"
install_brew "go"
