#!/usr/bin/env bash

# Add browser-tools configuration
browser_tools_config='{
  "command": "npx -y @agentdeskai/browser-tools-mcp",
  "enabled": true
}'

add_mcp_server "browser-tools" "$browser_tools_config"
