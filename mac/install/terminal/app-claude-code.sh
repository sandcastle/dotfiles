#!/usr/bin/env bash

# Claude Code
# https://github.com/anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code

# Create config directory
if [ ! -d "~/.claude" ]; then
 mkdir -p ~/.claude
fi

# Copy config files
cp -f $DOTFILES/configs/claude-code/ ~/.claude/
