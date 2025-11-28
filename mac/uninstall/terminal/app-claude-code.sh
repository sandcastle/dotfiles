#!/usr/bin/env bash

# Claude Code
# https://github.com/anthropic-ai/claude-code

brew uninstall claude-code

# Remove config files and directories
rm ~/.claude &> /dev/null || true
rm ~/.local/bin/claude &> /dev/null || true
rm ~/.local/share/claude &> /dev/null || true
rm ~/.local/share/cursor-agent &> /dev/null || true
rm ~/.local/state/claude &> /dev/null || true
rm ~/.cache/claude &> /dev/null || true

rm ~/.claude.json &> /dev/null || true
rm ~/.claude.json.backup &> /dev/null || true
