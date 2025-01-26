#!/usr/bin/env zsh

curl -sSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh

# Explicitly install required versions
bash /tmp/dotnet-install.sh --channel 8.0
bash /tmp/dotnet-install.sh --channel 9.0

# Install tools
dotnet tool install -g dotnet-ef
dotnet tool install -g dotnet-outdated-tool
dotnet tool install -g BenchmarkDotNet.Tool 
dotnet tool install -g xunit-cli
dotnet tool install -g dotnet-guid
dotnet tool install -g dotnet-format
