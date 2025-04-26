#!/usr/bin/env bash
set -e && ( set -o pipefail; ) 2>/dev/null || true

log_h1 "Python & Tools"

run_command "Installing Python" mise use -g python@latest
run_command "Installing UV" mise use -g uv@latest

# Install numpy for gcloud tunnel performance
CLOUDSDK_PYTHON_SITEPACKAGES=1
run_command "Installing numpy" $(gcloud info --format="value(basic.python_location)") -m pip install numpy
