#!/usr/bin/env zsh

# ==================================================================
# Visual Studio Code
# ==================================================================


code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }