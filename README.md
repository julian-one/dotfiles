# Dotfiles

Personal configuration files for macOS development environment.

## Quick Setup

```bash
git clone https://github.com/julian-one/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The setup script automatically:
- Installs Homebrew and required tools
- Backs up existing configurations
- Installs applications and dependencies
- Creates symlinks with stow
- Sets up tmux plugins and language servers

## What's Included

- **nvim** - Neovim with LSP, Telescope, Copilot, and modern plugins
- **tmux** - Terminal multiplexer with Catppuccin theme, TPM, and status plugins  
- **bash** - Shell configuration with aliases and environment setup
- **ghostty** - Modern terminal emulator configuration

## Directory Structure

```
dotfiles/
├── nvim/.config/nvim/     # Neovim configuration
├── tmux/.tmux.conf        # Tmux configuration
├── bash/                  # Bash profile and rc files
├── ghostty/               # Ghostty configuration
└── setup.sh              # Automated setup script
```

## Manual Installation

```bash
# Prerequisites
brew install stow git

# Individual configs
stow nvim -t ~
stow tmux -t ~
stow bash -t ~
stow ghostty -t ~
```

## Updating

```bash
cd ~/dotfiles && git pull && ./setup.sh
```
