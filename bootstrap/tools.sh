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
brew cask install qlimagesize
brew cask install webpquicklook
brew cask install betterzipql
brew cask install provisionql
brew cask install qlvideo
brew cask install syntax-highlight

# general
brew install openssl
brew install htop-osx
brew cask httpie
brew cask install rescuetime
brew cask install screenflow
brew cask install cardhop
brew cask install fantastical
brew cask install zoomus
brew cask install bartender

# security
brew cask install 1password

# media
brew cask install vlc
brew cask install plex-media-server
brew cask install sabnzbd
brew cask install spotify
brew cask install handbrake

# browsers
brew cask install firefox
brew cask install google-chrome
brew cask install postman

# cloud/kube
brew install kubernetes-cli
brew install kubernetes-helm
brew install kubectx
brew install awscli
brew install skaffold
brew cask install google-cloud-sdk
brew install kind
brew install kustomize
gcloud components update --quiet
gcloud components install pkg --quiet

# databases
brew cask install postgres
brew cask install navicat-for-postgresql
brew cask install dbeaver-community

# languages
brew cask install dotnet-sdk
brew cask install java
brew install python
brew install nvm
brew install yarn
brew install deno

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
brew cask install nucleo
brew cask install sketch

# gaming 
brew cask install discord

# commandline
brew install z
brew install jq

# iterm
brew cask install iterm2
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# git
brew install tig
brew install diff-so-fancy
