#!/usr/bin/env sh

set -e
cd "$(dirname "$0")/../.."

source "./bootstrap/_funcs.sh"

log_h1 "Installing .Net SDKs"

curl -sL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh

# Explicitly install required versions
sh /tmp/dotnet-install.sh --channel 8.0
sh /tmp/dotnet-install.sh --channel 9.0

# Load source env to contine
source "$(dirname "$0")/env.sh"

# Dev certs
dotnet dev-certs https --trust

# Install tools
dotnet tool install -g dotnet-ef
dotnet tool install -g dotnet-outdated-tool
dotnet tool install -g BenchmarkDotNet.Tool 
dotnet tool install -g xunit-cli
dotnet tool install -g dotnet-guid
dotnet tool install -g dotnet-format
