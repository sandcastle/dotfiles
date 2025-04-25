#!/usr/bin/env bash
set -e && ( set -o pipefail; ) 2>/dev/null || true

log_h1 "Python & Tools"

run_with_progress "Installing Python" true mise use -g python@latest
run_with_progress "Installing UV" true mise use -g uv@latest

# Install numpy for gcloud tunnel performance
CLOUDSDK_PYTHON_SITEPACKAGES=1
run_with_progress "Installing numpy" $(gcloud info --format="value(basic.python_location)") -m pip install numpy
