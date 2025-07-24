#!/usr/bin/env bash

for installer in $DOTFILES_PATH/mac/install/terminal/*.sh; do source $installer; done
