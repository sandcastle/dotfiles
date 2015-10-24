#!/usr/bin/env sh

branch=$1
if [[ -z $branch ]]; then
  echo "branch name not specified"
  exit 1
fi

git branch $branch
git checkout $branch