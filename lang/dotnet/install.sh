#!/usr/bin/env bash
set -e && ( set -o pipefail; ) 2>/dev/null || true

log_h1 "Installing .Net SDKs"

curl -sL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh

# Explicitly install required versions
log_h3 "Installing dotnet 8"
bash /tmp/dotnet-install.sh --channel 8.0

log_h3 "Installing dotnet 9"
bash /tmp/dotnet-install.sh --channel 9.0

# Load source env to contine
. $DOTFILES/lang/dotnet/env.sh

# Dev certs
dotnet dev-certs https --trust

# Install tools
dotnet tool install -g dotnet-ef
dotnet tool install -g dotnet-outdated-tool
dotnet tool install -g BenchmarkDotNet.Tool 
dotnet tool install -g xunit-cli
dotnet tool install -g dotnet-guid
dotnet tool install -g dotnet-format
