#!/usr/bin/env zsh

# Bootstraps an OSX machine

dev="$HOME/dev"
pushd .
mkdir -p $dev
cd $dev

echo 'Enter new hostname of the machine (e.g. macbook-glenn)'
    read hostname

echo "Setting new hostname to $hostname..."
    scutil --set HostName "$hostname"
    compname=$(sudo scutil --get HostName | tr '-' '.')

echo "Setting computer name to $compname"
    scutil --set ComputerName "$compname"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"


# OSX config
echo 'Tweaking OS X...'
source 'etc/osx.sh'


# bootstrap with brew
echo 'Homebrew...'
sh "bootstrap/bootstrap.sh"


pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'


echo 'Symlinking config files...'
source 'symlink-dotfiles.sh'

popd
