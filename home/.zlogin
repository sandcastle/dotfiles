# ==================================================================
# Executes commands at login post-zshrc
# ==================================================================

# Execute code that does not affect the current session in the background.
{
  # Set environment variables for launchd processes.
  if [[ "$OSTYPE" == darwin* ]]; then
    for env_var in PATH MANPATH; do
      launchctl setenv "$env_var" "${(P)env_var}"
    done
  fi
} &!
