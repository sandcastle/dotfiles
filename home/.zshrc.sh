# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
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

# pnpm
export PNPM_HOME="/Users/glenn/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# bun completions
[ -s "/Users/glenn/.bun/_bun" ] && source "/Users/glenn/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
