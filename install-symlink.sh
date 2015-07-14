#!/bin/bash

# This file is called by install.sh; it symlinks dotfiles to the $HOME path


DOT_FILES="$HOME/dev/dotfiles"

# debug message
echo "Symlinking dotfiles from $DOT_FILES"

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

for location in $(find home -name '.*'); do
  file="${location##*/}"
  file="${file%.sh}"
  link "$DOT_FILES/$location" "$HOME/$file"
done
