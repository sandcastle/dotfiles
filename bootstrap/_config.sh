# Get parent directory, works in both source and execution contexts
if [[ -n "${BASH_SOURCE[0]}" ]]; then
    DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
elif [[ -n "$0" ]]; then
    DOTFILES="$( cd "$( dirname "$0" )/.." && pwd )"
else 
    echo "Error: Cannot determine dotfiles location" >&2
    exit 1
fi

# Computer name
COMPUTER_NAME=${COMPUTER_NAME:-""}

# Git configuration
GIT_NAME=${GIT_NAME:-""}
GIT_EMAIL=${GIT_EMAIL:-""}

# Commonly used directories.
export DEV_HOME="$HOME/Developer"
export DEV_TMP="$DEV_HOME/tmp"
export DEV_WORK="$DEV_HOME/work"
export DEV_ME="$DEV_HOME/me"

# Feature flags
INSTALL_WORK_TOOLS=${INSTALL_WORK_TOOLS:-true}
INSTALL_PERSONAL_TOOLS=${INSTALL_PERSONAL_TOOLS:-true}

# Package selections
INSTALL_NODEJS=${INSTALL_NODEJS:-true}
INSTALL_PYTHON=${INSTALL_PYTHON:-true}
INSTALL_RUBY=${INSTALL_RUBY:-true}
INSTALL_GO=${INSTALL_GO:-true}
INSTALL_DOTNET=${INSTALL_DOTNET:-true}

# Cloud tools
INSTALL_AWS=${INSTALL_AWS:-true}
INSTALL_GCP=${INSTALL_GCP:-true} 
