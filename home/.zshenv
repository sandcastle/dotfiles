

# Docker.
# ---------
# Dont consume the default OTEL endpoint with docker
export DOCKER_CLI_OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:14317"

# Locale.
# ---------
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

# Paths.
# ------
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the the list of directories that cd searches.
cdpath=(
  $cdpath
)

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/bin
  $HOME/.local/bin
  /opt/homebrew/{bin,sbin}
  /usr/local/{bin,sbin}
  /usr/local/opt/go/libexec/bin
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# Temporary Files.
if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
# The _local files are for settings that are specific to the local machine only - not stored in dotfiles.
# Get the actual dotfiles directory path, handling both direct and symlinked cases
# Use the real path of ~/.zshenv to find dotfiles directory
if [[ -L "$HOME/.zshenv" ]]; then
  # Follow the symlink to get the real dotfiles location
  real_zshenv="$(readlink "$HOME/.zshenv")"
  export DOTFILES="$(dirname "$(dirname "$real_zshenv")")"
else
  # Fallback: assume standard location
  export DOTFILES="$HOME/.dotfiles"
fi

# Add mise to PATH
export PATH="$HOME/.mise/bin:$PATH"

# Performance optimization settings
HIST_STAMPS="yyyy-mm-dd"

# History configuration
HISTFILE="$HOME/.zsh_history"

for file in ~/.{exports,aliases,functions,exports_local,aliases_local,functions_local}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
