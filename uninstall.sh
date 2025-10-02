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

# Check if running from dotfiles directory
if [ ! -f "install.sh" ] || [ ! -d ".git" ]; then
    error "This script must be run from the dotfiles directory"
    exit 1
fi

info "Starting dotfiles uninstallation..."

# List of packages to unstow
PACKAGES=(
    "1password"
    "bash"
    "fzf"
    "ghostty"
    "git"
    "hypr"
    "nvim"
    "rofi"
    "tmux"
    "waybar"
)

# Unstow each package
for package in "${PACKAGES[@]}"; do
    if [ -d "$package" ]; then
        info "Unstowing $package..."
        stow -v -D -t ~ "$package" 2>/dev/null || warn "Could not unstow $package (might not be stowed)"
    else
        warn "Package directory $package not found, skipping..."
    fi
done

# Special handling for ghostty (stowed to ~/.config)
if [ -d "ghostty" ]; then
    info "Unstowing ghostty from ~/.config..."
    stow -v -D -t ~/.config "ghostty" 2>/dev/null || warn "Could not unstow ghostty"
fi

info "Looking for backup files to restore..."

# Function to restore backups
restore_backup() {
    local base_path="$1"
    local latest_backup=""

    # Find the most recent backup
    for backup in "${base_path}".backup.*; do
        if [ -e "$backup" ]; then
            latest_backup="$backup"
        fi
    done

    if [ -n "$latest_backup" ]; then
        read -p "Found backup: $latest_backup. Restore it? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            info "Restoring $latest_backup to $base_path"
            rm -rf "$base_path" 2>/dev/null || true
            cp -r "$latest_backup" "$base_path"
            info "Restored successfully"
        fi
    fi
}

# Check for backups
warn "Checking for configuration backups..."
restore_backup ~/.bashrc
restore_backup ~/.bash_profile
restore_backup ~/.config/ghostty
restore_backup ~/.config/nvim
restore_backup ~/.config/hypr
restore_backup ~/.config/waybar
restore_backup ~/.config/rofi
restore_backup ~/.tmux.conf
restore_backup ~/.config/git


echo ""
info "========================================="
info "Uninstallation complete!"
info "========================================="
info "Your dotfiles have been unstowed."
info "Backup files (*.backup.*) have been preserved."
info "Installed packages have NOT been removed."
echo ""
warn "To remove installed packages, review and run:"
echo "  sudo pacman -Rs base-devel git wget less stow tree"
echo "  (Be careful - some of these might be needed by other software)"
echo ""
info "To reinstall, run: ./install.sh"