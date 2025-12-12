#!/usr/bin/env bash

# Mise
# https://mise.jdx.dev/installing-mise.html#uninstalling

mise implode

rm -rf ~/.config/mise &> /dev/null || true
rm -rf ~/.local/share/mise &> /dev/null || true
rm -rf ~/.local/state/mise &> /dev/null || true
