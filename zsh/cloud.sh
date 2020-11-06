#!/usr/bin/env zsh


# ==================================================================
# Amazon Web Services
# ==================================================================

# CLI completion
source /usr/local/share/zsh/site-functions/_aws



# ==================================================================
# Google Cloud
# ==================================================================

# CLI mapping for py version
export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"



# ==================================================================
# Azure
# ==================================================================

# aliases
alias az='$HOME/bin/az'



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
