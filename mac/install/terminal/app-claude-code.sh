#!/usr/bin/env bash

# Claude Code
# https://github.com/anthropic-ai/claude-code
# https://code.claude.com/docs/en/overview
brew install --cask claude-code

# Create config directory
if [ ! -d "~/.claude" ]; then
 mkdir -p ~/.claude
fi

# Copy config files
cp -rf $DOTFILES/configs/claude-code/* ~/.claude/
