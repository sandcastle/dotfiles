#!/usr/bin/env zsh

# check if brew is installed
which -s brew

# install brew, if required
if [[ $? != 0 ]]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
fi

# install cask
brew install caskroom/cask/brew-cask

# set cask link folder
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

sh "bootstrap/tools.sh"
sh "bootstrap/dotnet.sh"
sh "bootstrap/aws.sh"
sh "bootstrap/go.sh"
sh "bootstrap/nvm.sh"
sh "bootstrap/py.sh"
sh "bootstrap/browsers.sh"
