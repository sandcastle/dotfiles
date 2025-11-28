#!/usr/bin/env bash

# Claude Code
# https://github.com/anthropic-ai/claude-code

# Remove binary files and config
rm -rf ~/.local/bin/claude &> /dev/null || true
rm -rf ~/.local/share/claude &> /dev/null || true
rm -rf ~/.local/share/cursor-agent &> /dev/null || true
rm -rf ~/.local/state/claude &> /dev/null || true
rm -rf ~/.claude &> /dev/null || true
rm -rf ~/.cache/claude &> /dev/null || true

rm -f ~/.claude.json &> /dev/null || true
rm -f ~/.claude.json.backup &> /dev/null || true
