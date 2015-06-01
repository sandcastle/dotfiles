#!/usr/bin/env zsh

# add tap
brew tap aspnet/dnx
brew update

# install latest dnx
brew install dnvm
dnvm upgrade
