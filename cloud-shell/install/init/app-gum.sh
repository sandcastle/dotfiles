#!/usr/bin/env bash

# Gum
# https://github.com/charmbracelet/gum
echo "Installing Gum..."

TAG=$(curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest \
  | grep -Eo '"tag_name": *"[^"]+"' \
  | cut -d'"' -f4)

# Detect architecture (supports x86_64 and arm64)
ARCH=$(uname -m)
case $ARCH in
  x86_64) ARCH_SUFFIX="x86_64" ;;
  aarch64|arm64) ARCH_SUFFIX="arm64" ;;
  *) echo "Unsupported architecture: $ARCH" && exit 1 ;;
esac

# Create tmp dir and download
TMP_DIR=$(mktemp -d)
curl -L "https://github.com/charmbracelet/gum/releases/download/$TAG/gum_${TAG#v}_Linux_${ARCH_SUFFIX}.tar.gz" \
  -o "$TMP_DIR/gum.tar.gz"

# Extract and install
tar -xzf "$TMP_DIR/gum.tar.gz" -C "$TMP_DIR"
mkdir -p ~/.local/bin

# Find the gum binary (it might be in a subdirectory)
GUM_BINARY=$(find "$TMP_DIR" -name "gum" -type f 2>/dev/null | head -1)
if [ -z "$GUM_BINARY" ]; then
  echo "Error: Could not find gum binary in extracted tarball"
  ls -la "$TMP_DIR"
  exit 1
fi

mv "$GUM_BINARY" ~/.local/bin/
chmod +x ~/.local/bin/gum

# Clean up
rm -rf "$TMP_DIR"

# Confirm installation
~/.local/bin/gum --version
