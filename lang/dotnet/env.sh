#!/usr/bin/env zsh

# ==================================================================
# Dotnet
# ==================================================================

# Dotnet explicit SDKs & tools paths
export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"

# ==================================================================
# Mono
# ==================================================================

# Mono paths
export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin"

alias dotnet-update="sh '$HOME/Developer/dotfiles/lang/dotnet/update.sh'"
