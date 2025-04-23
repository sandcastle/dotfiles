#!/usr/bin/env bash

set -e
cd "$(dirname "$0")/../.."

source "./bootstrap/_funcs.sh"

log_h1 "Updating .Net SDKs"

curl -sL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh

echo "Installing latest version of 8.0..."
bash /tmp/dotnet-install.sh --channel 8.0

echo "Installing latest version of 9.0..."
bash /tmp/dotnet-install.sh --channel 9.0