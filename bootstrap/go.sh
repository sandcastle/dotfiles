#!/usr/bin/env zsh

# install go
brew install go

# create go path
mkdir "$HOME/go"

# install go tools
go get -u golang.org/x/tools/cmd/...
