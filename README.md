# Dotfiles

My opinionated dotfiles and macOS setup for a productive development environment.

## Quick Install

```bash
curl -s "https://raw.githubusercontent.com/sandcastle/dotfiles/master/install.sh?t=$(date +%s%N)" | bash
```

## Updating

Run the `dotfiles-update` alias to trigger an update.

```bash
dotfiles-update
```

## Features

- 🚀 One-command installation
- ⚡️ Performance-optimized ZSH configuration
- 🛠 Modern CLI tools and replacements
- 🔧 Sensible macOS & linux defaults
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

- MSIE
- Node
- Python
- Ruby
- Go
- Dotnet
- Docker and Kubernetes tools

### Shell Configuration

- ZSH
- Syntax highlighting
- Auto-suggestions
- Smart completions
- Git integrations

## What's Included

### Core Tools

- Development tools (git, gh, jq, etc.)
- Modern CLI replacements
- Terminal emulator (iTerm2)
- Shell enhancements (ZSH + plugins, Starship)
- Code editors (Neovim, VS Code, Cursor)

### Development Tools

- Language environments (Node.js, Python, Ruby, Go, .NET)
- Container tools (Docker, kubectl, helm)
- Cloud CLIs (AWS, GCP, Azure)
- Infrastructure as Code (Terraform)

### Configuration

- Git configuration and aliases
- ZSH configuration and functions
- VS Code & Cursor settings
- iTerm2 profile
- macOS system preferences

## Structure

```
.
├── bootstrap/          # Installation scripts
│   ├── common/         # Cross-platform scripts
│   ├── linux/          # Linux-specific scripts
│   └── macos/          # macOS-specific scripts
│
├── etc/                # System configuration files
│
├── home/               # Home directory dotfiles
│   ├── bin/            #
│   ├── .vim/           # Vim workspace
│   ├── .config/        # Starship config files
│   ├── .aliases        # Shell aliases
│   └── .functions      # Shell functions
│
├── lang/               # Language-specific setup
│   ├── dotnet/         # dotnet configuration
│   ├── go/             # Go configuration
│   ├── node/           # Node configuration
│   ├── python/         # Python configuration
│   └── ruby/           # Ruby configuration
│
└── tools/              # Tool-specific configuration
    ├── cursor/         # Cursor editor settings
    ├── mcp/            # MCP tool configuration
    └── vscode/         # VS Code settings
```

## Credits

Inspired by various dotfiles, including:

- [Paul Miller](https://github.com/paulmillr/dotfiles)
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
- [Zach Holman](https://github.com/holman/dotfiles)

## License

MIT License.
