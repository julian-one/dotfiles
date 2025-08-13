# Dotfiles

Personal development environment configuration for macOS and Arch Linux.

## Features

- **Neovim** - LSP, Telescope, Copilot, and 30+ plugins with modular Lua configuration
- **Zsh** - Powerlevel10k prompt, syntax highlighting, autosuggestions, and custom completions
- **Tmux** - Custom status bar, Catppuccin theme, vi-mode navigation
- **Ghostty** - Modern terminal with Comic Code Ligatures and blur effects
- **Git** - Aliases and conditional work profile includes
- **Fonts** - Comic Code with ligatures for coding

## Quick Start

```bash
git clone https://github.com/julian-one/dotfiles.git ~/dotfiles
cd ~/dotfiles
make all
```

The Makefile will:
- Install package manager (Homebrew/pacman) and required packages
- Back up existing configurations  
- Create symlinks to dotfiles
- Install Comic Code fonts
- Install tmux plugins and language servers
- Verify installation

## Available Commands

```bash
make all              # Full setup (install + stow + verify)
make install          # Install all packages and dependencies
make stow             # Create configuration symlinks
make verify           # Verify installation and links
make clean            # Remove all symlinks
make info             # Show system information
make help             # Show all available commands
```

### Individual Components
```bash
make install-packages    # Install core packages
make install-zsh-plugins # Install zsh plugins
make install-fonts       # Install Comic Code fonts
make stow-nvim           # Link neovim configuration only
make stow-zsh            # Link zsh configuration only
make stow-tmux           # Link tmux configuration only
```

## Structure

```
dotfiles/
├── nvim/          # Neovim configuration
├── zsh/           # Shell configuration
├── tmux/          # Tmux configuration
├── ghostty/       # Terminal configuration
├── git/           # Git configuration
└── Makefile       # Cross-platform setup
```

## Platform Support

### macOS (Intel & Apple Silicon)
- **Package Manager**: Homebrew
- **Auto-detection**: Intel (`/usr/local`) vs Apple Silicon (`/opt/homebrew`)
- **Prerequisites**: Command Line Tools for Xcode

### Arch Linux
- **Package Manager**: pacman + yay (AUR)
- **Auto-installation**: yay will be installed automatically if not present
- **Prerequisites**: base-devel group

## Manual Installation

### macOS
```bash
# Prerequisites
brew install stow neovim tmux ripgrep fd fzf

# Create symlinks
make stow
```

### Arch Linux
```bash
# Prerequisites
sudo pacman -S stow neovim tmux ripgrep fd fzf
yay -S lua-language-server  # Optional

# Create symlinks  
make stow
```

## License

MIT