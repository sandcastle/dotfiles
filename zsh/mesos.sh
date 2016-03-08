#!/usr/bin/env zsh

# ==================================================================
# Mesos
# ==================================================================


VIRTUAL_ENV_PATH="$(python -c "import os; print(os.path.realpath('"${ARGS[0]}"'))")"
export PATH="$VIRTUAL_ENV_PATH/bin:${PATH}"
