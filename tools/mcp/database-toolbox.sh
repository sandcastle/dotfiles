#!/usr/bin/env bash

# Add browser-tools configuration
config='{
  "command": "~/.local/bin/genai-toolbox",
  "args": ["--prebuilt","bigquery","--stdio"],
  "env": {
    "BIGQUERY_PROJECT": "<PROJECT_ID>"
  },
  "enabled": true
}'
