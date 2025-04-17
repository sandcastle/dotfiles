# Homebrew.
# ---------
HOMEBREW_NO_ENV_HINTS=true

# Editors.
# --------
export EDITOR='code'
export KUBE_EDITOR="nvim"
export PAGER='moar'

# Moar pager.
# ---------
export MOAR_PAGER='less' # Use less as the pager for moar's own help pages
export MOAR_STYLE='plain' # Set a clean, readable style with syntax highlighting
export MOAR_KEYBINDINGS='q:quit,h:help,j:down,k:up,g:top,G:bottom,f:forward,b:backward,/:search,n:next,N:prev'

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

# Commonly used directories.
export DEV_HOME="$HOME/Developer"
export DEV_TMP="$DEV_HOME/tmp"
export DEV_WORK="$DEV_HOME/work"
export DEV_ME="$DEV_HOME/me"

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
  /usr/local/{bin,sbin}
  /usr/local/opt/ruby/bin
  /usr/local/lib/python2.7/site-packages
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
