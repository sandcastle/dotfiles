#!/usr/bin/env bash

log_h1 "Configuring developer settings"

# Xcode command line tools check/install
if ! xcode-select -p &>/dev/null; then
    log_info "Installing Xcode Command Line Tools..."
    xcode-select --install
    log_success "Xcode Command Line Tools installed"
else
    log_success "Xcode Command Line Tools already installed"
fi

sudo xcodebuild -license

# Setup SSH key & link to Github
pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa
echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'

# languages
. $DOTFILES/lang/js/install.sh
. $DOTFILES/lang/dotnet/install.sh
. $DOTFILES/lang/python/install.sh
. $DOTFILES/lang/go/install.sh

# languages
log_info "Installing programming languages"
install_brew "java"
install_brew "powershell"
