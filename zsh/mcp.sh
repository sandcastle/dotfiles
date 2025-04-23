#!/usr/bin/env bash

# ==================================================================
# Servers
# ==================================================================

# Browser Tools (https://browsertools.agentdesk.ai/)
alias mcp-browser-tools="yes | npx @agentdeskai/browser-tools-server"


# ==================================================================
# Control Common MCP Servers
# ==================================================================

alias mcp-init="$DOTFILES/tools/mcp/init.sh"
alias mcp-start="mcp-browser-tools"
alias mcp-stop="pkill -f 'browser-tools-server'"
