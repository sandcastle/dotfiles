#!/usr/bin/env zsh

# check if brew is installed
which -s brew

# install brew, if required
if [[ $? != 0 ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo >> /Users/glenn/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/glenn/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

    brew update
fi

# set cask link folder
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

sh "bootstrap/mac_os.sh"

# tools
sh "bootstrap/tools.sh"
