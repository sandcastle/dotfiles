#!/usr/bin/env bash

echo "Installing GenAI MCP Toolbox..."
# https://cloud.google.com/bigquery/docs/pre-built-tools-with-mcp-toolbox#mcp-configure-your-mcp-client-cursor

mkdir -p ~/.local/bin

temp_file=$(mktemp)
curl -fsSL -o "$temp_file" https://storage.googleapis.com/genai-toolbox/v0.7.0/darwin/arm64/toolbox

mv "$temp_file" ~/.local/bin/genai-toolbox
chmod +x ~/.local/bin/genai-toolbox

echo
echo "Installed Version:"
~/.local/bin/genai-toolbox --version
