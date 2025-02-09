#!/usr/bin/env zsh


# ==================================================================
# Amazon Web Services
# ==================================================================



# ==================================================================
# Google Cloud
# ==================================================================

# CLI mapping for py version
export CLOUDSDK_PYTHON=python3
source "$(gcloud info --format='value(installation.sdk_root)')/path.zsh.inc"
source "$(gcloud info --format='value(installation.sdk_root)')/completion.zsh.inc"



# ==================================================================
# Kubernetes
# ==================================================================

# Editor for edit command
export KUBE_EDITOR=vi

# aliases
alias kube='kubectl'
alias kubeproxy='kube proxy &'



# ==================================================================
# Docker
# ==================================================================

# aliases - Docker
alias dk='docker'

# aliases - Docker Compose
alias dkc='docker-compose'
alias dkcu='docker-compose up'
alias dkcd='docker-compose up -d'
alias dkcs='docker-compose stop'
