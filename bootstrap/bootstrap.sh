#!/usr/bin/env zsh

# check if brew is installed
which -s brew

# install brew, if required
if [[ $? != 0 ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
fi

# set cask link folder
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

sh "bootstrap/mac_os.sh"

# tools
sh "bootstrap/tools.sh"
