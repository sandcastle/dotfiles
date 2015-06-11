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

# install quick lookup plugins - http://github.com/sindresorhus/quick-look-plugins
brew cask install suspicious-package
brew cask install quicklook-json
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install webpquicklook

# install dev tools
brew install htop
brew install nginx
brew install trash

# install languages
sh "langs/dnx.sh"
sh "langs/go.sh"
sh "langs/nvm.sh"



pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'


echo 'Symlinking config files...'
source 'symlink-dotfiles.sh'

popd
