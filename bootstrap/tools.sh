#!/usr/bin/env zsh

set -e
cd "$(dirname "$0")/.."

source "$(dirname "$0")/_funcs.sh"

# iterm
install_brew "iterm2" "iTerm"
curl -sL https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# dotnet
sh ./lang/js/install.sh

# dotnet
sh ./lang/dotnet/install.sh

# python
sh ./lang/python/install.sh

# #ruby
# sh ./lang/ruby/install.sh
# sh ./lang/ruby/check.sh

# helper tools
install_brew "trash"
install_brew "tree"
install_brew "bash-completion"

# general
install_brew "openssl"
install_brew "htop-osx"
install_brew "httpie"
install_brew "cardhop"
install_brew "fantastical"
install_brew "bartender"

# security
install_brew "1password-cli"
install_brew "cloudflare-warp"

# media
install_brew "vlc"
install_brew "plex-media-server"
install_brew "sabnzbd"
install_brew "spotify"
install_brew "handbrake"

# browsers
install_brew "google-chrome" "Google Chrome"

# cloud/kube
install_brew "kubernetes-cli"
install_brew "kubernetes-helm"
install_brew "kubectx"
install_brew "skaffold"
install_brew "google-cloud-sdk"
gcloud components update --quiet
gcloud components install gke-gcloud-auth-plugin --quiet
gcloud components install gsutil --quiet
install_brew "awscli"

# languages
install_brew "java"
install_brew "powershell"

# go
install_brew "go"
mkdir "$HOME/go"
go get -u golang.org/x/tools/cmd/...

# tools
install_brew "jetbrains-toolbox"
install_brew "visual-studio-code"
install_brew "terraform"
install_brew "docker"
install_brew "surge"
install_brew "ngrok"

# design
install_brew "cleanshot"
install_brew "pixelsnap"
install_brew "figma"
install_brew "drawio"
install_brew "colour-contrast-analyser"
install_brew "losslesscut"
install_brew "imageoptim"

# gaming 
install_brew "discord"

# commandline
install_brew "z"
install_brew "jq"

# git
install_brew "github"
install_brew "gitkraken"
install_brew "tig"
install_brew "diff-so-fancy"

install_ohmyzsh() {
    echo "Installing Oh My Zsh..."
    
    # Backup existing zsh files
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="$HOME/.zsh_backup_$timestamp"
    mkdir -p "$backup_dir"
    
    # Backup existing zsh files
    for file in ".zshrc" ".zshenv" ".zprofile" ".zlogin"; do
        if [ -f "$HOME/$file" ]; then
            cp "$HOME/$file" "$backup_dir/"
        fi
    done
    
    # Install Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Install custom plugins
    local plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
    
    # zsh-autosuggestions
    if [ ! -d "$plugins_dir/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
    fi
    
    # fast-syntax-highlighting (faster alternative to zsh-syntax-highlighting)
    if [ ! -d "$plugins_dir/fast-syntax-highlighting" ]; then
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$plugins_dir/fast-syntax-highlighting"
    fi
    
    # powerlevel10k theme
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    fi
    
    echo "Oh My Zsh installation complete!"
}

source ~/Developer/dotfiles/bootstrap/tools.sh && install_ohmyzsh
