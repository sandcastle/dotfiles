#!/usr/bin/env zsh

# A simple script for setting up OSX dev environment.

dev="$HOME/dev"
pushd .
mkdir -p $dev
cd $dev

echo 'Enter new hostname of the machine (e.g. macbook-paulmillr)'
  read hostname
  
echo "Setting new hostname to $hostname..."
  scutil --set HostName "$hostname"
  compname=$(sudo scutil --get HostName | tr '-' '.')
  
echo "Setting computer name to $compname"
  scutil --set ComputerName "$compname"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"

pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
  [[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
  [[ -f $pub ]] && cat $pub | pbcopy
  open 'https://github.com/account/ssh'

# Ensure we are on OSX
if [[ `uname` == 'Darwin' ]]; then
  
  which -s brew
  
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/homebrew/go/install)"
      brew update
      brew install htop mysql nginx node ruby
  fi

  echo 'Tweaking OS X...'
    source 'etc/osx.sh'

  # http://github.com/sindresorhus/quick-look-plugins
  echo 'Installing Quick Look plugins...'
    brew tap phinze/homebrew-cask
    brew install brew-cask
    brew cask install suspicious-package quicklook-json qlmarkdown qlstephen qlcolorcode
  
  echo 'Installing dev tools'
    brew install ghi
    brew install trash
fi

echo 'Symlinking config files...'
  source 'bin/symlink-dotfiles.sh'

popd
