#!/usr/bin/env bash

if command -v cursor &>/dev/null; then
  cursor --install-extension $VSC_EXTENSION >/dev/null

  OS_NAME=$(uname -s)
  if [ "$OS_NAME" == "Darwin" ]; then

    CURSOR_SETTINGS="$HOME/Library/Application Support/Cursor/User/settings.json"
    sed -i "" "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$VSC_THEME\"/g" "$CURSOR_SETTINGS"

  elif [ "$OS_NAME" == "Linux" ] && grep -q "Ubuntu" /etc/os-release 2>/dev/null; then

    CURSOR_SETTINGS="$HOME/.config/Cursor/User/settings.json"
    sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$VSC_THEME\"/g" "$CURSOR_SETTINGS"

  fi

fi
