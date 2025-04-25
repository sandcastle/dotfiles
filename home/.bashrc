#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Get dotfiles directory
if [[ -n "${BASH_SOURCE[0]}" ]]; then
  DOTFILES="$( cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.." && pwd )"
elif [[ -n "$0" ]]; then
  DOTFILES="$( cd "$(dirname "$0")/.." && pwd )"
else 
  echo "Error: Cannot determine dotfiles location" >&2
  exit 1
fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source dotfiles
command find "$DOTFILES/zsh" -name '*.sh' -type f -print0 | while IFS= read -r -d $'\0' file; do
  if [ -r "$file" ]; then
    . "$file"
  fi
done

# Initialize modern tools
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)" # Modern prompt
fi
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"   # Smarter cd command
fi
