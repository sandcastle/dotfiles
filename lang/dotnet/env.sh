#!/usr/bin/env zsh

# ==================================================================
# Dotnet
# ==================================================================

# Dotnet explicit SDKs & tools paths
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"

# ==================================================================
# Tools
# ==================================================================

alias dotnet-update="sh '$HOME/Developer/dotfiles/lang/dotnet/update.sh'"
