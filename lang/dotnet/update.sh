#!/usr/bin/env bash

set -e

log_h1 "Updating .Net SDKs"

curl -sL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh

echo "Installing dotnet 8"
bash /tmp/dotnet-install.sh --channel 8.0

echo "Installing dotnet 9"
bash /tmp/dotnet-install.sh --channel 9.0
