#!/usr/bin/env sh

# ==================================================================
# Dotnet
# ==================================================================

# Dotnet explicit SDKs & tools paths
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"

# ==================================================================
# Tools
# ==================================================================

alias dotnet-update="sh '$DOTFILES/lang/dotnet/update.sh'"
