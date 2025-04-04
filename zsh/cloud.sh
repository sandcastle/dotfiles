#!/usr/bin/env zsh

# ==================================================================
# Google Cloud
# ==================================================================

[ -f ~/.config/gcloud/application_default_credentials.json ] && \
  export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/application_default_credentials.json


# CLI mapping for py version
export CLOUDSDK_PYTHON=python3
source "$(gcloud info --format='value(installation.sdk_root)')/path.zsh.inc"
source "$(gcloud info --format='value(installation.sdk_root)')/completion.zsh.inc"


# ==================================================================
# Kubernetes
# ==================================================================

# Editor for edit command
export KUBE_EDITOR=nvim

# aliases
alias k='kubectl'
alias kube='kubectl'
alias kubeproxy='kube proxy &'
