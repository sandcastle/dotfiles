
DOT_FILES="$HOME/dev/dotfiles"

# Terminal config
source "$DOT_FILES/terminal/startup.sh"
source "$DOT_FILES/terminal/completion.sh"
source "$DOT_FILES/terminal/highlight.sh"

# ZSH
source "$DOT_FILES/zsh/aliases.sh"
source "$DOT_FILES/zsh/cloud.sh"
source "$DOT_FILES/zsh/dotnet.sh"
source "$DOT_FILES/zsh/functions.sh"
source "$DOT_FILES/zsh/git.sh"
source "$DOT_FILES/zsh/go.sh"
source "$DOT_FILES/zsh/node.sh"
source "$DOT_FILES/zsh/osx.sh"
source "$DOT_FILES/zsh/ruby.sh"
source "$DOT_FILES/zsh/tools.sh"

# Colors
autoload -U colors && colors

# Load and execute the prompt theming system.
fpath=("$DOT_FILES/terminal" $fpath)
autoload -Uz promptinit && promptinit
prompt 'sandcastle'

eval $(/usr/libexec/path_helper -s)

# fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
