#!/bin/bash

source "$(dirname "$0")/_funcs.sh"

log_h1 "Setting up MCP servers"

DEV_PATH="$HOME/Developer"
MCP_PATH="$DEV_PATH/mcp"

mkdir -p "$MCP_PATH"

cd "$MCP_PATH"

# Browser Tools
git clone --depth 1 https://github.com/agentdeskai/browser-tools-server.git
