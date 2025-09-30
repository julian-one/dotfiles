#!/bin/bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    error "Please don't run this script as root"
    exit 1
fi

# Backup function
backup_existing() {
    if [ -e "$1" ]; then
        local backup_path="$1.backup.$(date +%Y%m%d_%H%M%S)"
        info "Backing up $1 to $backup_path"
        cp -r "$1" "$backup_path"
    fi
}

# Core packages
info "Installing core packages..."
sudo pacman -S --noconfirm --needed base-devel git wget less stow tree

# Development tools
info "Installing development tools..."
sudo pacman -S --noconfirm --needed go nodejs npm tree-sitter-cli
sudo pacman -S --noconfirm --needed bash-completion fzf ripgrep fd git-delta playerctl bat

# Setup npm global packages directory
info "Setting up npm global packages directory..."
if [ ! -d ~/.npm-global ]; then
    mkdir ~/.npm-global
fi
npm config set prefix '~/.npm-global'

# Desktop environment
info "Installing desktop environment packages..."
sudo pacman -S --noconfirm --needed waybar hyprpaper otf-font-awesome rofi

# Applications
info "Installing applications..."
sudo pacman -S --noconfirm --needed ghostty

# Audio setup (PipeWire stack)
info "Setting up audio system..."
sudo pacman -S --noconfirm --needed pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
sudo pacman -S --noconfirm --needed alsa-utils pavucontrol

# PipeWire services are socket-activated, ensure they're running
info "Starting PipeWire audio services..."
systemctl --user start pipewire.socket pipewire-pulse.socket || true
systemctl --user start wireplumber.service || true

# Verify PipeWire services are running
info "Verifying PipeWire services..."
sleep 2  # Give services time to start
if systemctl --user is-active --quiet pipewire.socket && \
   systemctl --user is-active --quiet pipewire-pulse.socket && \
   systemctl --user is-active --quiet wireplumber.service; then
    info "✓ PipeWire audio services are running"
else
    warn "PipeWire services may not have started correctly"
    warn "You can check status with: systemctl --user status pipewire wireplumber"
fi

# Brightness control
info "Installing brightness control..."
sudo pacman -S --noconfirm --needed brightnessctl

# Screenshot tools
info "Installing screenshot tools..."
sudo pacman -S --noconfirm --needed grim slurp swappy wl-clipboard

# Bluetooth support
info "Setting up bluetooth..."
sudo pacman -S --noconfirm --needed bluez bluez-utils
sudo systemctl enable --now bluetooth.service

# Use GNU Stow for dotfiles management
info "Setting up dotfiles with GNU Stow..."

# Backup existing configurations before stowing
info "Backing up existing configurations..."
backup_existing ~/.bashrc
backup_existing ~/.bash_profile
backup_existing ~/.config/ghostty
backup_existing ~/.config/nvim
backup_existing ~/.config/hypr
backup_existing ~/.config/waybar
backup_existing ~/.config/rofi
backup_existing ~/.tmux.conf
backup_existing ~/.config/git

# Remove existing files/symlinks that would conflict
info "Removing conflicting files..."
[ -L ~/.bashrc ] && rm ~/.bashrc
[ -L ~/.bash_profile ] && rm ~/.bash_profile
[ -L ~/.tmux.conf ] && rm ~/.tmux.conf

# Stow configurations
info "Stowing bash configuration..."
if ! stow -v -R -t ~ bash; then
    error "Failed to stow bash configuration"
    exit 1
fi

# Setup ghostty
info "Stowing ghostty configuration..."
[ -L ~/.config/ghostty ] && rm -rf ~/.config/ghostty
[ -d ~/.config/ghostty ] && rm -rf ~/.config/ghostty
if ! stow -v -R -t ~ ghostty; then
    error "Failed to stow ghostty configuration"
    exit 1
fi

# Install yay (AUR helper)
info "Setting up AUR helper..."
if ! command -v yay &> /dev/null; then
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	makepkg -si --noconfirm
	cd
	rm -rf /tmp/yay
fi

# Install AUR packages
info "Installing AUR packages..."
yay -S --noconfirm --needed neovim-nightly-bin
yay -S --noconfirm --needed blueberry
yay -S --noconfirm --needed 1password
yay -S --noconfirm --needed brave-bin

# Set Brave as default browser (handled via BROWSER env variable in .bash_profile)
info "Brave set as default browser via BROWSER environment variable"

# Link neovim config
info "Stowing neovim configuration..."
[ -L ~/.config/nvim ] && rm ~/.config/nvim
if ! stow -v -R -t ~ nvim; then
    error "Failed to stow neovim configuration"
    exit 1
fi

# Link hyprland config
info "Stowing hyprland configuration..."
[ -L ~/.config/hypr ] && rm ~/.config/hypr
[ -d ~/.config/hypr ] && rm -rf ~/.config/hypr
if ! stow -v -R -t ~ hypr; then
    error "Failed to stow hyprland configuration"
    exit 1
fi

# Link waybar config
info "Stowing waybar configuration..."
[ -L ~/.config/waybar ] && rm ~/.config/waybar
[ -d ~/.config/waybar ] && rm -rf ~/.config/waybar
if ! stow -v -R -t ~ waybar; then
    error "Failed to stow waybar configuration"
    exit 1
fi

# Link rofi config
info "Stowing rofi configuration..."
[ -L ~/.config/rofi ] && rm ~/.config/rofi
[ -d ~/.config/rofi ] && rm -rf ~/.config/rofi
if ! stow -v -R -t ~ rofi; then
    error "Failed to stow rofi configuration"
    exit 1
fi

# Setup wallpaper
info "Setting up wallpaper..."
if [ ! -d ~/Pictures ]; then
    mkdir -p ~/Pictures
fi
cp ~/dotfiles/wallpaper/wallpaper.jpg ~/Pictures/wallpaper.jpg

# Install custom font
info "Installing custom font..."
FONT_NAME="ComicCodeLigaturesNerdFont.otf"
FONT_SOURCE="$HOME/dotfiles/fonts/$FONT_NAME"
FONT_DEST="/usr/share/fonts/truetype/nerdfonts/$FONT_NAME"

if [ ! -f "$FONT_DEST" ]; then
    info "Installing Comic Code Nerd Font..."
    if [ ! -f "$FONT_SOURCE" ]; then
        error "Font file not found at $FONT_SOURCE"
        exit 1
    fi
    sudo mkdir -p /usr/share/fonts/truetype/nerdfonts
    sudo cp "$FONT_SOURCE" "$FONT_DEST"
    info "Updating font cache..."
    sudo fc-cache -f 2>/dev/null
    info "Font installed successfully."
else
    info "Comic Code Nerd Font already installed, skipping..."
fi

# Link git configuration
info "Stowing git configuration..."
[ -L ~/.config/git ] && rm -rf ~/.config/git
[ -d ~/.config/git ] && backup_existing ~/.config/git && rm -rf ~/.config/git
if ! stow -v -R -t ~ git; then
    error "Failed to stow git configuration"
    exit 1
fi

# Stow tmux configuration
info "Stowing tmux configuration..."
if ! stow -v -R -t ~ tmux; then
    error "Failed to stow tmux configuration"
    exit 1
fi

# Stow fzf configuration
info "Stowing fzf configuration..."
if ! stow -v -R -t ~ fzf; then
    error "Failed to stow fzf configuration"
    exit 1
fi

# Stow 1password desktop entry
info "Stowing 1password configuration..."
if ! stow -v -R -t ~ 1password; then
    error "Failed to stow 1password configuration"
    exit 1
fi

# GitHub SSH setup (optional - run separately)
info "========================================="
info "GitHub SSH Setup"
info "========================================="
if [ ! -f ~/.ssh/id_ed25519 ]; then
    warn "No SSH key found for GitHub"
    info "To set up GitHub SSH authentication, run:"
    info "  ./github.sh"
    info ""
    read -p "Would you like to set up GitHub SSH now? (y/N) " -n 1 -r
    info ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Running GitHub SSH setup..."
        ./github.sh
    else
        info "You can set up GitHub SSH later by running: ./github.sh"
    fi
else
    info "✓ SSH key already exists for GitHub"
fi

info ""
info "========================================="
info "Installation complete!"
info "========================================="
info "Dotfiles have been installed using GNU Stow."
info "To uninstall, run: ./uninstall.sh"
info "Please restart waybar or reload your session for changes to take effect."
