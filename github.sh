#!/bin/bash

# GitHub SSH Key Setup Script
# This script sets up SSH authentication for GitHub

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
prompt() { echo -e "${BLUE}[?]${NC} $1"; }

# Configuration
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
SSH_KEY_COMMENT="julian-one@github"

echo ""
echo "========================================="
echo "      GitHub SSH Key Setup"
echo "========================================="
echo ""

# Check if SSH key already exists
if [ -f "$SSH_KEY_PATH" ]; then
    warn "SSH key already exists at $SSH_KEY_PATH"

    # Show the public key
    info "Your existing SSH public key is:"
    echo ""
    cat "${SSH_KEY_PATH}.pub"
    echo ""

    read -p "Do you want to create a new key? This will backup the existing one. (y/N) " -n 1 -r
    echo

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Using existing SSH key"

        # Test GitHub connection
        info "Testing SSH connection to GitHub..."
        if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
            info "✓ SSH connection to GitHub is working!"
        else
            warn "SSH key exists but GitHub connection failed"
            warn "Make sure to add the above key to: https://github.com/settings/keys"
        fi

        exit 0
    fi

    # Backup existing key
    backup_dir="$HOME/.ssh/backup_$(date +%Y%m%d_%H%M%S)"
    info "Backing up existing SSH keys to $backup_dir"
    mkdir -p "$backup_dir"
    mv "$SSH_KEY_PATH" "$backup_dir/"
    mv "${SSH_KEY_PATH}.pub" "$backup_dir/"
fi

# Create .ssh directory if it doesn't exist
if [ ! -d "$HOME/.ssh" ]; then
    info "Creating ~/.ssh directory..."
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
fi

# Get user email for the key
prompt "Enter email for SSH key (or press Enter for default: $SSH_KEY_COMMENT):"
read -r email_input
EMAIL="${email_input:-$SSH_KEY_COMMENT}"

# Generate new SSH key
info "Generating new ED25519 SSH key..."
ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEY_PATH" -N ""

# Start ssh-agent if not running
if ! pgrep -x ssh-agent > /dev/null; then
    info "Starting ssh-agent..."
    eval "$(ssh-agent -s)"
fi

# Add SSH key to ssh-agent
info "Adding SSH key to ssh-agent..."
ssh-add "$SSH_KEY_PATH"

# Create SSH config if it doesn't exist
SSH_CONFIG="$HOME/.ssh/config"
if [ ! -f "$SSH_CONFIG" ]; then
    info "Creating SSH config..."
    touch "$SSH_CONFIG"
    chmod 600 "$SSH_CONFIG"
fi

# Add GitHub host configuration if not present
if ! grep -q "Host github.com" "$SSH_CONFIG"; then
    info "Adding GitHub configuration to SSH config..."
    cat >> "$SSH_CONFIG" << EOF

# GitHub
Host github.com
    HostName github.com
    User git
    IdentityFile $SSH_KEY_PATH
    AddKeysToAgent yes
EOF
fi

# Display the public key
echo ""
echo "========================================="
echo " SSH PUBLIC KEY - Add this to GitHub"
echo "========================================="
echo ""
cat "${SSH_KEY_PATH}.pub"
echo ""
echo "========================================="
echo ""

info "Steps to complete setup:"
echo "  1. Copy the SSH public key above"
echo "  2. Go to: https://github.com/settings/keys"
echo "  3. Click 'New SSH key'"
echo "  4. Paste the key and give it a descriptive title"
echo "  5. Click 'Add SSH key'"
echo ""

# Wait for user to add key
read -p "Press Enter once you've added the key to GitHub..."

# Test SSH connection
info "Testing SSH connection to GitHub..."
echo ""

if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    info "✓ SSH connection successful!"
    echo ""

    # Offer to update dotfiles remote
    if [ -d "$HOME/dotfiles/.git" ]; then
        cd "$HOME/dotfiles"
        current_remote=$(git remote get-url origin 2>/dev/null || echo "")

        if [[ "$current_remote" == "https://"* ]]; then
            warn "Current remote uses HTTPS: $current_remote"
            read -p "Switch to SSH remote? (Y/n) " -n 1 -r
            echo

            if [[ ! $REPLY =~ ^[Nn]$ ]]; then
                info "Updating remote to use SSH..."
                git remote set-url origin git@github.com:julian-one/dotfiles.git
                info "✓ Remote updated to: git@github.com:julian-one/dotfiles.git"
            fi
        elif [[ "$current_remote" == "git@"* ]]; then
            info "✓ Repository already uses SSH remote"
        fi
    fi

    echo ""
    info "========================================="
    info " GitHub SSH Setup Complete!"
    info "========================================="
    info "You can now push/pull using SSH authentication"

else
    error "SSH connection to GitHub failed!"
    error "Please verify that you added the key correctly to GitHub"
    echo ""
    warn "You can test the connection manually with:"
    echo "  ssh -T git@github.com"
    exit 1
fi