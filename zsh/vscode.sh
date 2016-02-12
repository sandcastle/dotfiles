#!/usr/bin/env zsh

# ==================================================================
# Visual Studio Code
# ==================================================================

# enable Salsa engine (https://code.visualstudio.com/updates#vscode)
export VSCODE_TSJS=1

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }
