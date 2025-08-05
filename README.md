# Dotfiles

Personal configuration files for macOS development environment with automated setup and modern tooling.

## What's Included

- **nvim** - Neovim with LSP, Telescope, Copilot, and 33+ modern plugins
- **tmux** - Terminal multiplexer with Catppuccin theme, TPM, and custom status bar
- **bash** - Shell configuration with aliases, history settings, and environment setup
- **ghostty** - Modern terminal emulator with custom fonts and transparency
- **git** - Git configuration with useful aliases and modern defaults

## Features

- 🚀 **One-command setup** - Complete environment setup with `./setup.sh`
- 🔄 **Intelligent backup** - Automatically backs up existing configurations
- 🔗 **GNU Stow integration** - Clean symlink management for all configurations
- 📦 **Automatic dependencies** - Installs Homebrew, language servers, and tools
- 🎨 **Consistent theming** - Catppuccin Latte theme across tmux and ghostty
- ⚡ **Performance optimized** - Lazy-loaded Neovim plugins and fast tmux config

## Directory Structure

```
dotfiles/
├── nvim/.config/nvim/           # Neovim configuration (33 Lua files)
│   ├── init.lua                 # Main entry point
│   └── lua/config/              # Modular plugin configurations
├── tmux/.tmux.conf              # Tmux with custom status bar and TPM
├── bash/                        # Bash shell configuration
│   ├── .bash_profile            # Login shell settings
│   └── .bashrc                  # Interactive shell aliases
├── ghostty/config               # Modern terminal emulator config
├── git/.gitconfig               # Git aliases and user settings
└── setup.sh                    # 425-line automated setup script
```

## Quick Setup

```bash
git clone https://github.com/julian-one/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The setup script automatically:
- ✅ Installs Homebrew and required tools (neovim, tmux, ripgrep, fd, fzf)
- 🛡️ Backs up existing configurations with timestamps
- 📦 Installs applications and language servers (lua-language-server, typescript-language-server, pyright)  
- 🔗 Creates clean symlinks using GNU Stow
- 🔌 Sets up tmux plugin manager (TPM) and installs plugins
- ✨ Configures environment variables and shell settings

## What Gets Installed

### Applications & Tools
- Neovim with LSP support
- Tmux with plugin manager
- Ghostty terminal (if available via Homebrew)
- ripgrep, fd, fzf for file searching
- Node.js and npm for language servers
- bash-completion@2 for enhanced tab completion

### Language Servers
- lua-language-server for Lua
- typescript-language-server for TypeScript/JavaScript  
- pyright for Python (via npm)

### Tmux Plugins (via TPM)
- Catppuccin theme
- tmux-battery for battery status
- tmux-online-status for network status

## Manual Installation

If you prefer manual setup or want to install specific configurations:

```bash
# Prerequisites
brew install stow git neovim tmux

# Individual configs
stow nvim -t ~        # Neovim configuration
stow tmux -t ~        # Tmux configuration  
stow bash -t ~        # Bash shell settings
stow ghostty -t ~     # Ghostty terminal config
stow git -t ~         # Git configuration
```

## Key Features by Tool

### Neovim
- Lazy.nvim plugin manager for fast startup
- LSP integration with language servers
- Telescope for fuzzy finding
- GitHub Copilot integration
- Modular configuration split across 33 Lua files

### Tmux  
- Custom status bar with session, command, and path info
- Catppuccin Latte theme for consistency
- Battery and network status indicators
- Vi-mode key bindings
- Smart pane navigation with Ctrl+hjkl

### Bash
- Comprehensive aliases for git, navigation, and safety
- Enhanced history settings (10k entries, no duplicates)
- Color support for ls and grep
- Environment variables for editor and paths
- Advanced tab completion for commands, files, and git operations

### Ghostty
- Comic Code Ligatures font at 18pt
- Background blur and transparency
- Catppuccin Latte theme
- macOS-specific optimizations
- Shell integration features

