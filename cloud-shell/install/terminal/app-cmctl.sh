#!/usr/bin/env bash

# Cert-Manager CLI(cmctl)
# https://cert-manager.io/docs/reference/cmctl/
echo "Installing Cert-Manager CLI(cmctl)..."

mkdir -p ~/.local/bin

temp_file=$(mktemp)
OS=$(go env GOOS); ARCH=$(go env GOARCH); curl -fsSL -o "$temp_file" https://github.com/cert-manager/cmctl/releases/latest/download/cmctl_${OS}_${ARCH}

# Move to final location and make executable
mv "$temp_file" ~/.local/bin/cmctl
chmod +x ~/.local/bin/cmctl

echo
echo "Installed Version:"
~/.local/bin/cmctl version
