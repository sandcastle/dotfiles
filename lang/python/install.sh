#!/usr/bin/env sh

set -e
cd "$(dirname "$0")/../.."

source "./bootstrap/_funcs.sh"

log_h1 "Installing Python"

install_brew "python3"

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install numpy for gcloud tunnel performance
CLOUDSDK_PYTHON_SITEPACKAGES=1
$(gcloud info --format="value(basic.python_location)") -m pip install numpy
