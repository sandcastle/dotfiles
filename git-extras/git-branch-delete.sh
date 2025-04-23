#!/usr/bin/env bash

branch=$1
if [[ -z $branch ]]; then
  echo "branch name not specified"
  exit 1
fi

git checkout master
git sync
git branch -D $branch
git branch -d -r origin/$branch
git push origin --delete $branch
