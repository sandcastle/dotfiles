#!/usr/bin/env bash

if command -v code &>/dev/null; then
  code --install-extension $VSC_EXTENSION >/dev/null

  OS_NAME=$(uname -s)
  if [ "$OS_NAME" == "Darwin" ]; then

    CODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
    sed -i "" "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$VSC_THEME\"/g" "$CODE_SETTINGS"

  elif [ "$OS_NAME" == "Linux" ] && grep -q "Ubuntu" /etc/os-release 2>/dev/null; then

    CODE_SETTINGS="$HOME/.config/Code/User/settings.json"
    sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$VSC_THEME\"/g" "$CODE_SETTINGS"

  fi

fi
