#!/usr/bin/env zsh

# Bootstraps an OSX machine

dev="$HOME/Developer"
pushd .
mkdir -p $dev


DOT_FILES="$dev/dotfiles"

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
source "$DOT_FILES/etc/osx.sh"


# bootstrap with brew
echo 'Homebrew...'
sh "$DOT_FILES/bootstrap/bootstrap.sh"


pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'


echo 'Symlinking config files...'
source './install-symlink.sh'

popd
