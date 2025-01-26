#!/usr/bin/env zsh

echo "Updating dotnet SDKs..."

curl -sSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh

echo "Installing latest version of 8.0..."
bash /tmp/dotnet-install.sh --channel 8.0

echo "Installing latest version of 9.0..."
bash /tmp/dotnet-install.sh --channel 9.0