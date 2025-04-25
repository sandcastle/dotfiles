#!/usr/bin/env bash

log_h1 "Configuring Linux UI preferences"

# Desktop environment settings (GNOME/KDE/etc)
if command -v gsettings >/dev/null; then
  # Check if GNOME schema exists before applying settings
  if gsettings list-schemas | grep -q "org.gnome.desktop.interface"; then
    gsettings set org.gnome.desktop.interface enable-animations true
  fi
fi
