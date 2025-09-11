#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values from JSON
model_name=$(echo "$input" | jq -r '.model.display_name')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
output_style=$(echo "$input" | jq -r '.output_style.name')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Get just the directory name (like \W in PS1)
dir_name=$(basename "$current_dir")

# Get git branch if in a git repo
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null || echo "HEAD")
    git_info=" 🌱 $branch"
else
    git_info=""
fi

# Check if we're in a Node.js project
if [[ -f "$current_dir/package.json" ]]; then
    node_info=" 📦"
else
    node_info=""
fi

# Build the status line
status_line="$model_name in $git_info$node_info"

# Only show output style if not default
if [[ "$output_style" != "default" ]]; then
    status_line="$status_line • $output_style"
fi

# Only show lines if there are any added or removed
if [[ "$lines_added" -gt 0 ]] || [[ "$lines_removed" -gt 0 ]]; then
    status_line="$status_line • +$lines_added/-$lines_removed lines"
fi

# Always show cost with US$ prefix
status_line="$status_line • US \$$(printf "%.2f" "$cost")"

# Output the status line and current folder on next line
echo "$status_line"
echo "$dir_name"
