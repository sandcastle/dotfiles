#!/usr/bin/env sh

source "$(dirname "$0")/_funcs.sh"

log_h1 "Setting up MCP servers"

export DEV_MCP="$DEV_HOME/mcp"

mkdir -p "$DEV_MCP"

cd "$DEV_MCP"

# Browser Tools
git clone --depth 1 https://github.com/agentdeskai/browser-tools-server.git
