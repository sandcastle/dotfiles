#!/usr/bin/env zsh

# ==================================================================
# OSX
# ==================================================================


# Short-cuts for copy-paste.
alias c='pbcopy'
alias p='pbpaste'

# Remove all items safely, to Trash (`brew install trash`).
alias rm='trash'

# Case-insensitive pgrep that outputs full path.
alias pgrep='pgrep -fli'

# Lock current session and proceed to the login screen.
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Sniff network info.
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

# Process grep should output full paths to binaries.
alias pgrep='pgrep -fli'

# Hide / show files
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'