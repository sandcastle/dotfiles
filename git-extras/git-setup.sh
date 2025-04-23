#!/usr/bin/env bash

repo="$1"

if [[ -z "$repo" ]]; then
  echo "Syntax: git setup user/project"
  exit
fi

git init && \
  touch 'README.md' 'CHANGELOG.md' && \
  cp "$HOME/.gitignore" '.gitignore' && \
  git save && \
  git first && \
  git remote add origin "git@github.com:$repo" && \
  git up
