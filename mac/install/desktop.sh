#!/usr/bin/env bash

for installer in $DOTFILES_PATH/mac/install/desktop/*.sh; do source $installer; done
