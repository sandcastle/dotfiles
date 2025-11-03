#!/usr/bin/env bash
set -e

# Terraform
# https://developer.hashicorp.com/terraform/install
echo "Installing Terraform..."

# Get the latest version from HashiCorp's checkpoint API
LATEST_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | grep -oP '"current_version":"\K[^"]+')

if [ -z "$LATEST_VERSION" ]; then
    echo "❌ Failed to detect latest version"
    exit 1
fi

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

OS="linux"
DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${LATEST_VERSION}/terraform_${LATEST_VERSION}_${OS}_${ARCH}.zip"

curl -LO "$DOWNLOAD_URL"

unzip -o "terraform_${LATEST_VERSION}_${OS}_${ARCH}.zip"

mv terraform ~/.local/bin/
chmod +x ~/.local/bin/terraform

rm -f "terraform_${LATEST_VERSION}_${OS}_${ARCH}.zip"

echo "Installed Version:"
~/.local/bin/terraform version
