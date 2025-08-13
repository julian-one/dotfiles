# Minimal Dotfiles

Minimal development environment configuration for macOS and Arch Linux, following the philosophy of using built-in features and default appearance.

## Philosophy

This configuration embraces minimalism:
- **Built-in features only** - No external plugins or themes
- **Default appearance** - No custom colors or styling
- **Essential functionality** - Only what's actually needed
- **Fast and reliable** - Minimal dependencies, quick startup

## Features

- **Neovim** - Minimal config with essential plugins (treesitter, blink.cmp, harpoon) and comprehensive LSP support
- **Bash** - Built-in features only, simple prompt with git branch display
- **Ghostty** - Modern terminal with Comic Code font and minimal configuration
- **Git** - Work profile configuration support
- **Fonts** - Comic Code Ligatures for enhanced coding experience
- **Cross-platform** - Automated setup for macOS and Arch Linux

## Quick Start

```bash
git clone https://github.com/julian-one/dotfiles.git ~/dotfiles
cd ~/dotfiles
make all
```

The Makefile will:
- Install package manager (Homebrew/pacman) and core packages
- Create symlinks to dotfiles
- Install Comic Code fonts
- Install essential language servers
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
make install-fonts       # Install Comic Code fonts
make stow-bash           # Link bash configuration only
make stow-nvim           # Link neovim configuration only
make stow-ghostty        # Link ghostty configuration only
make stow-git            # Link git configuration only
```

## Structure

```
dotfiles/
├── bash/          # Bash shell configuration (.bashrc, .bash_profile)
├── nvim/          # Neovim configuration (minimal with comprehensive LSP)
├── ghostty/       # Ghostty terminal configuration
├── git/           # Git configuration (work profile)
├── fonts/         # Comic Code Ligatures font files
└── Makefile       # Cross-platform setup automation
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
brew install stow neovim ripgrep fd fzf lua-language-server ghostty

# Create symlinks
make stow
```

### Arch Linux
```bash
# Prerequisites  
sudo pacman -S stow neovim ripgrep fd fzf
yay -S lua-language-server ghostty  # Optional

# Create symlinks  
make stow
```

## License

MIT