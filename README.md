# Dotfiles

My opinionated dotfiles and macOS setup for a productive development environment.

## Features

- 🚀 One-command installation
- ⚡️ Performance-optimized ZSH configuration
- 🛠 Modern CLI tools and replacements
- 🔧 Sensible macOS defaults
- 🔄 Git workflow enhancements
- 🖥 Development environment setup

### Modern CLI Tools

- [bat](https://github.com/sharkdp/bat) - Better `cat` with syntax highlighting
- [exa](https://github.com/ogham/exa) - Modern `ls` replacement
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Faster `grep`
- [fd](https://github.com/sharkdp/fd) - User-friendly `find`
- [delta](https://github.com/dandavison/delta) - Better git diffs
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter `cd`
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [starship](https://starship.rs) - Cross-shell prompt

### Development Environments

- Node.js with NVM
- Python with pyenv
- Ruby with rbenv
- Go
- .NET Core
- Docker and Kubernetes tools

### Shell Configuration

- ZSH with Oh My Zsh
- Powerlevel10k theme
- Syntax highlighting
- Auto-suggestions
- Smart completions
- Git integrations
- Cloud CLI tools (AWS, GCP, Azure)

## Installation

### Quick Install

```bash
curl --silent https://raw.githubusercontent.com/sandcastle/dotfiles/master/install.sh | bash
```

### Manual Install

1. Clone the repository:
```bash
git clone --recursive https://github.com/sandcastle/dotfiles.git ~/Developer/dotfiles
```

2. Run the installer:
```bash
cd ~/Developer/dotfiles
./install.sh
```

## What's Included

### Core Tools

- Development tools (git, gh, jq, etc.)
- Modern CLI replacements
- Terminal emulator (iTerm2)
- Shell enhancements (ZSH + plugins)
- Code editor (VS Code)

### Development Tools

- Language environments (Node.js, Python, Ruby, Go)
- Container tools (Docker, kubectl, helm)
- Cloud CLIs (AWS, GCP)
- Infrastructure as Code (Terraform)

### Configuration

- Git configuration and aliases
- ZSH configuration and functions
- VS Code settings
- iTerm2 profile
- macOS system preferences

## Structure

```
.
├── bootstrap/          # Installation scripts
├── home/              # Home directory dotfiles
├── zsh/               # ZSH configuration
│   ├── aliases.sh     # Shell aliases
│   ├── functions.sh   # Shell functions
│   └── tools.sh       # Tool-specific config
├── lang/              # Language-specific setup
├── git-extras/        # Git helper scripts
└── vscode/           # VS Code settings
```

## Customization

1. Fork this repository
2. Modify the configurations in `home/` directory
3. Add/remove packages in `install.sh`
4. Adjust macOS settings in `bootstrap-osx.sh`
5. Update shell configurations in `zsh/`

## Updating

To update your dotfiles:

```bash
cd ~/Developer/dotfiles
git pull
./install.sh
```

## Credits

Inspired by various dotfiles repositories, including:
- [Paul Miller's dotfiles](https://github.com/paulmillr/dotfiles)
- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)

## License

MIT License. See [LICENSE](LICENSE) for details.

