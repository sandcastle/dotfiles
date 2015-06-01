#!/usr/bin/env zsh

# install go
brew install go --cross-compile-common
mkdir $HOME/.go
export GOPATH=$HOME/.go
