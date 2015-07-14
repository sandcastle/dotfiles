#!/usr/bin/env zsh

# A simple script for setting up OSX dev environment.

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

# check if brew is installed
which -s brew

# install brew, if required
if [[ $? != 0 ]]; then

    echo 'Installing Homebrew...'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/homebrew/go/install)"
    brew update

fi

# install cask
brew install caskroom/cask/brew-cask

# set cask link folder
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# install languages
sh "bootstrap/osx-tools.sh"
sh "bootstrap/atom.sh"
sh "bootstrap/dnx.sh"
sh "bootstrap/go.sh"
sh "bootstrap/nvm.sh"
sh "bootstrap/py.sh"
sh "bootstrap/gcloud.sh"


pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'


echo 'Symlinking config files...'
source 'symlink-dotfiles.sh'

popd
