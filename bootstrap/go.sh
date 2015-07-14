#!/usr/bin/env zsh

# install go
brew install go --with-cc-common
mkdir $HOME/.go
export GOPATH=$HOME/.go

# install go tools
go get -u golang.org/x/tools/cmd/...
go get -u github.com/golang/lint/golint
