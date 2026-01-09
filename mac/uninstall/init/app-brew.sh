#!/usr/bin/env bash

# Homebrew
if ! command -v brew >/dev/null; then
  rm $(which brew) &> /dev/null || true
fi
