#!/usr/bin/env bash

# Claude Code
# https://github.com/anthropic-ai/claude-code
# https://code.claude.com/docs/en/overview
curl -fsSL https://claude.ai/install.sh | bash

# Create config directory
if [ ! -d "~/.claude" ]; then
 mkdir -p ~/.claude
fi

# Copy config files
cp -f $DOTFILES/configs/claude-code/ ~/.claude/
