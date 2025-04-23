#!/usr/bin/env bash

log_h1 "Configuring Linux UI preferences"

# Desktop environment settings (GNOME/KDE/etc)
if command -v gsettings >/dev/null; then
    # GNOME settings
    gsettings set org.gnome.desktop.interface enable-animations true
fi
