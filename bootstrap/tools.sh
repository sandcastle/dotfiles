#!/usr/bin/env zsh

# helper tools
brew install trash
brew install tree

# quick lookup plugins
# http://github.com/sindresorhus/quick-look-plugins
brew cask install suspicious-package
brew cask install quicklook-json
brew cask install quicklook-csv
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install webpquicklook
brew cask install betterzipql
brew cask install provisionql

# general
brew install openssl
brew install htop-osx
brew cask install rescuetime
brew cask install screenflow
brew cask install cardhop
brew cask install fantastical
brew cask install zoomus
brew cask install setapp

# security
brew cask install 1password

# media
brew cask install vlc
brew cask install plex-media-server
brew cask install sabnzbd

# browsers
brew cask install firefox
brew cask install google-chrome
brew cask install postman

# cloud
brew install kubernetes-cli
brew install kubernetes-helm
brew install kubectx
brew install awscli
brew cask install google-cloud-sdk

# databases
brew cask install postgres
brew cask install navicat-for-postgresql

# languages
brew cask install dotnet-sdk
brew cask install java
brew install python
brew install nvm
brew install yarn

# go
brew install go
mkdir "$HOME/go"
go get -u golang.org/x/tools/cmd/...

# tools
brew cask install tower
brew cask install visual-studio-code
brew cask install terraform
brew cask install docker
brew cask install kitematic
brew cask install colour-contrast-analyser
brew cask install surge

# commandline
brew install z

# JSON parser for commandline
brew install jq
