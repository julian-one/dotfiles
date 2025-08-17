# Dotfiles

Modern, minimal development environment focused on simplicity and productivity.

## Quick Start

```bash
git clone https://github.com/julian-one/dotfiles.git ~/dotfiles
cd ~/dotfiles
make all
```

## Commands

```bash
make all              # Complete setup (install + link)
make install          # Install packages via Homebrew
make link             # Create configuration symlinks
make clean            # Remove symlinks
make verify           # Verify installation
make help             # Show all commands
```

## What's Included

### 🚀 Core Tools
- **Neovim** - Modern editor with LSP, treesitter, and fuzzy finding
- **Ghostty** - Fast terminal with Comic Code Ligatures font
- **Bash** - Enhanced shell with vi mode and git integration
- **Git** - Streamlined configuration

### 📦 Dependencies
- **Homebrew** - Package manager for macOS
- **Git** - Version control
- **Neovim** - Text editor
- **Ripgrep** - Fast text search
- **fd** - Fast file finder
- **fzf** - Fuzzy finder
- **tree-sitter** - Syntax highlighting

## Configuration Highlights

- **Unified color scheme** - Vague.nvim theme across all tools
- **Vi mode everywhere** - Consistent keybindings
- **LSP-powered development** - Go, TypeScript, Svelte, HTML, CSS support
- **Smart history** - Enhanced command history with timestamps
- **XDG compliance** - Proper config directory structure

## Structure

```
dotfiles/
├── bash/           # Shell configuration
│   ├── .bashrc     # Interactive shell settings
│   └── .bash_profile # Login shell environment
├── ghostty/        # Terminal configuration
│   └── config      # Theme and display settings
├── git/            # Git configurations
│   └── work.gitconfig # Work profile
├── nvim/           # Neovim configuration
│   └── .config/nvim/init.lua # Single-file config
├── fonts/          # Comic Code Ligatures font
└── Makefile        # Automated setup
```

## Customization

Edit configurations directly:
- **Neovim**: `nvim ~/.config/nvim/init.lua`
- **Bash**: `nvim ~/.bashrc`
- **Terminal**: `nvim ~/.config/ghostty/config`

## Troubleshooting

Run `make verify` to check installation status. Common issues:
- **Homebrew not found**: Install from [brew.sh](https://brew.sh)
- **Symlinks not created**: Check file permissions
- **LSP not working**: Run `:Mason` in Neovim to install language servers

## License

MIT
