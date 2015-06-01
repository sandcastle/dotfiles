#!/usr/bin/env zsh

# install go
brew install go --with-cc-common
mkdir $HOME/.go
export GOPATH=$HOME/.go
