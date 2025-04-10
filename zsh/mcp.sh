#!/usr/bin/env zsh

# ==================================================================
# Servers
# ==================================================================

# Browser Tools (https://browsertools.agentdesk.ai/)
alias mcp-browser-tools="yes | npx @agentdeskai/browser-tools-server"


# ==================================================================
# Control Common MCP Servers
# ==================================================================

alias mcp-start="mcp-browser-tools"
alias mcp-stop="pkill -f 'browser-tools-server'"
