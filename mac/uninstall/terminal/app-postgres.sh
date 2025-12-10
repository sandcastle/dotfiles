#!/usr/bin/env bash

# Postgres (for psql CLI)
brew uninstall postgresql@17

# When uninstalling, some dead symlinks are left behind
brew cleanup --prune-prefix
