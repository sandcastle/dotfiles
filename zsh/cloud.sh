#!/usr/bin/env bash

# ==================================================================
# Google Cloud
# ==================================================================

[ -f $HOME/.config/gcloud/application_default_credentials.json ] && \
  export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/application_default_credentials.json


# CLI mapping for py version
export CLOUDSDK_PYTHON=python3
export CLOUDSDK_PYTHON_SITEPACKAGES=1

GCLOUD_SDK_ROOT=$(gcloud info --format='value(installation.sdk_root)')
if [ -f "$GCLOUD_SDK_ROOT/path.zsh.inc" ]; then
  source "$GCLOUD_SDK_ROOT/path.zsh.inc"
fi

if [ -f "$GCLOUD_SDK_ROOT/completion.zsh.inc" ]; then
  source "$GCLOUD_SDK_ROOT/completion.zsh.inc"
fi


# ==================================================================
# Kubernetes
# ==================================================================

# Editor for edit command
export KUBE_EDITOR=nvim

# aliases
alias k='kubectl'
alias kube='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias kubeproxy='kube proxy &'


# ==================================================================
# Digital Ocean
# ==================================================================
