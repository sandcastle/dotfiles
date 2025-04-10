#!/usr/bin/env sh

source "$DOTFILES/bootstrap/_funcs.sh"

MCP_TOOLS_DIR="$DOTFILES/tools/mcp"
MCP_FILE="$HOME/.cursor/mcp.json"
TMP_MCP_FILE=$(mktemp)

# Ensure the MCP file exists and cloned to the tmp file
ensure_mcp_file() {
  # Create the file if it doesn't exist
  if [ ! -f "$MCP_FILE" ]; then
    log_info "Creating MCP config file $MCP_FILE"
    echo '{ "mcpServers": { } }' > "$MCP_FILE"
  fi
  cp "$MCP_FILE" "$TMP_MCP_FILE"
}

# Function to add an MCP server configuration
add_mcp_server() {
  local name="$1"
  local json="$2"

  if grep -q "\"$name\"" "$MCP_FILE"; then
    echo "  $(log_info "$name already setup")"
  else 
    jq ".mcpServers |= (. + $json )" "$MCP_FILE" > "$TMP_MCP_FILE"
    echo "  $(log_success "Added $name")"
  fi
}

# Finalise the tmp file
finalise_tmp_file() {
  log_info "Validating MCP config"

  # Validate JSON format
  if ! jq empty "$TMP_MCP_FILE" 2>/dev/null; then
    log_error "Invalid JSON format in $TMP_MCP_FILE" 
    exit 1
  fi

  # Replace the original MCP file with the temporary file
  mv "$TMP_MCP_FILE" "$MCP_FILE"

  log_success "MCP setup"
}

main() {
  # Ensure the MCP file exists and tmp file is created
  ensure_mcp_file

  # Add the MCP tools
  log_info "Adding MCP tools"
  add_mcp_server "browser-tools" '
  "browser-tools": {
      "command": "npx -y @agentdeskai/browser-tools-mcp",
      "enabled": true
    }
  '

  finalise_tmp_file
}

main
