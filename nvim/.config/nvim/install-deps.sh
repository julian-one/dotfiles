#!/bin/bash

set -e

echo "=========================================="
echo "Neovim Dependencies Installer"
echo "=========================================="
echo ""

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/fedora-release ]; then
        OS="fedora"
    elif [ -f /etc/debian_version ]; then
        OS="debian"
    elif [ -f /etc/arch-release ]; then
        OS="arch"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
fi

echo "Detected OS: $OS"
echo ""

# ========================================
# System Packages
# ========================================

echo "Installing system packages..."

if [ "$OS" = "fedora" ]; then
    sudo dnf install -y fzf ripgrep fd-find git lua-language-server gopls nodejs npm
elif [ "$OS" = "debian" ]; then
    sudo apt update
    sudo apt install -y fzf ripgrep fd-find git lua-language-server gopls nodejs npm
elif [ "$OS" = "arch" ]; then
    sudo pacman -S --needed fzf ripgrep fd git lua-language-server gopls nodejs npm
elif [ "$OS" = "macos" ]; then
    brew install fzf ripgrep fd git lua-language-server gopls node
else
    echo "⚠️  Unknown OS. Please install manually: fzf, ripgrep, fd, git, lua-language-server, gopls, nodejs, npm"
fi

echo "✓ System packages installed"
echo ""

# ========================================
# npm Packages (LSP servers & formatters)
# ========================================

echo "Installing npm packages..."

if command -v npm &> /dev/null; then
    npm install -g \
      @olrtg/emmet-language-server \
      vscode-langservers-extracted \
      svelte-language-server \
      typescript-language-server \
      @tailwindcss/language-server \
      yaml-language-server \
      dockerfile-language-server-nodejs \
      @fsouza/prettierd \
      sql-formatter

    echo "✓ npm packages installed"
else
    echo "⚠️  npm not found. Skipping npm packages."
fi

echo ""

# ========================================
# Go Tools
# ========================================

echo "Installing Go tools..."

if command -v go &> /dev/null; then
    go install github.com/a-h/templ/cmd/templ@latest
    go install mvdan.cc/gofumpt@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install github.com/segmentio/golines@latest

    echo "✓ Go tools installed"
else
    echo "⚠️  Go not found. Skipping Go tools."
    echo "   Install Go and run:"
    echo "   go install github.com/a-h/templ/cmd/templ@latest"
    echo "   go install mvdan.cc/gofumpt@latest"
    echo "   go install golang.org/x/tools/cmd/goimports@latest"
    echo "   go install github.com/segmentio/golines@latest"
fi

echo ""

# ========================================
# Rust Tools (stylua)
# ========================================

echo "Installing Rust tools..."

if command -v cargo &> /dev/null; then
    cargo install stylua
    echo "✓ Rust tools installed"
else
    echo "⚠️  Cargo not found. Skipping stylua."
    echo "   Install Rust and run: cargo install stylua"
    echo "   Or use system package: sudo dnf install stylua (Fedora)"
fi

echo ""

# ========================================
# Summary
# ========================================

echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Open Neovim"
echo "2. Run: :TSInstall lua go javascript typescript svelte html css json yaml bash markdown"
echo ""
echo "Installed:"
echo "  ✓ System tools (fzf, ripgrep, fd, git)"
echo "  ✓ LSP servers (12 total)"
echo "  ✓ Formatters (7 total)"
echo ""
echo "Optional: Install additional LSPs as needed"
echo ""
