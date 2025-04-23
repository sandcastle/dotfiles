#!/usr/bin/env bash

source "$(dirname "$0")/_funcs.sh"

log_h1 "Setting up MCP servers"

export DEV_MCP="$DEV_HOME/mcp"

mkdir -p "$DEV_MCP"
cd "$DEV_MCP"

# Browser Tools
if [ ! -d "$DEV_MCP/browser-tools-mcp" ]; then  
    git clone --depth 1 https://github.com/AgentDeskAI/browser-tools-mcp.git
else
    cd "$DEV_MCP/browser-tools-mcp"
    git pull --depth 1
fi

# Memory Tools
if [ ! -d "$DEV_MCP/memory-tools-mcp" ]; then
    git clone --depth 1 https://github.com/AgentDeskAI/memory-tools-mcp.git
else
    cd "$DEV_MCP/memory-tools-mcp"
    git pull --depth 1
fi

