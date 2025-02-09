#!/bin/bash

echo "Setting up Linux environment..."

# Install required packages
if command -v apt-get &> /dev/null; then
    # For Debian/Ubuntu based systems (which Google Cloud Shell uses)
    echo "Installing essential packages..."
    sudo apt-get update
    sudo apt-get install -y \
        git \
        curl \
        wget \
        zsh \
        vim \
        jq \
        tree \
        unzip \
        python3 \
        python3-pip

    # Install Node.js and npm using n version manager
    echo "Installing Node.js..."
    curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
    sudo bash n lts
    rm n

    # Install common Python packages
    echo "Installing Python packages..."
    pip3 install --user \
        virtualenv \
        pylint \
        black \
        flake8

    # Install additional development tools
    echo "Installing development tools..."
    # Install latest version of gh (GitHub CLI)
    type -p curl >/dev/null || sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y

elif command -v yum &> /dev/null; then
    # For RedHat/CentOS based systems
    echo "Installing essential packages..."
    sudo yum update -y
    sudo yum install -y \
        git \
        curl \
        wget \
        zsh \
        vim \
        jq \
        tree \
        unzip \
        python3 \
        python3-pip

    # Similar installations for Node.js, Python packages, and development tools
    # ... (similar to apt-get section but using yum where appropriate)
fi

# Create common directories
mkdir -p "$HOME/Developer"
mkdir -p "$HOME/.config"

# Set up Git configuration
if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
fi

# Set up any Linux-specific aliases or functions
cat >> "$HOME/.zshrc" << 'EOL'

# Linux-specific aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias open='xdg-open'

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"
EOL

echo "Linux environment setup complete!" 