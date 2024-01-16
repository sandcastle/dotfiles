#!/usr/bin/env zsh

# helper tools
brew install trash
brew install tree

# general
brew install openssl
brew install htop-osx
brew install httpie
brew install cardhop
brew install fantastical
brew install zoomus
brew install bartender

# security
brew install 1password
brew install 1password-cli
brew install cloudflare-warp

# media
brew install vlc
brew install plex-media-server
brew install sabnzbd
brew install spotify
brew install handbrake

# browsers
brew install google-chrome

# cloud/kube
brew install kubernetes-cli
brew install kubernetes-helm
brew install kubectx
brew install awscli
brew install skaffold
brew install google-cloud-sdk
gcloud components update --quiet
gcloud components install gke-gcloud-auth-plugin --quiet
gcloud components install gsutil --quiet

# databases
brew install postgres
brew install pgcli

# languages
brew install dotnet-sdk
brew install java
brew install python3
brew install nvm
brew install yarn
brew install pnpm
brew install powershell

# go
brew install go
mkdir "$HOME/go"
go get -u golang.org/x/tools/cmd/...

# tools
brew install jetbrains-toolbox
brew install visual-studio-code
brew install terraform
brew install docker
brew install surge
brew install ngrok

# design
brew install cleanshot
brew install pixelsnap
brew install figma
brew install drawio
brew install colour-contrast-analyser
brew install losslesscut
brew install imageoptim

# gaming 
brew cask install discord

# commandline
brew install z
brew install jq
brew install fig

# iterm
brew install iterm2
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

#bun
curl -fsSL https://bun.sh/install | bash

# git
brew install github
brew install gitkraken
brew install tig
brew install diff-so-fancy

# dotnet
dotnet tool install -g dotnet-ef
dotnet tool install -g dotnet-outdated-tool
dotnet tool install -g BenchmarkDotNet.Tool 
dotnet tool install -g xunit-cli
dotnet tool install -g dotnet-guid
dotnet tool install -g dotnet-format