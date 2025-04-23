#!/usr/bin/env bash

# ==================================================================
# OSX
# ==================================================================

# Lock current session and proceed to the login screen.
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Sniff network info.
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

# Hide / show files
alias showfiles='defaults write -g AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write -g AppleShowAllFiles -bool false && killall Finder'

# Hide/show all desktop icons (useful when presenting)
alias showdeskicons="defaults write com.apple.Finder CreateDesktop -bool true && killall Finder"
alias hidedeskicons="defaults write com.apple.Finder CreateDesktop -bool false && killall Finder"

# Flush the DNS (Yosemite 10.10.4+)
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed"
