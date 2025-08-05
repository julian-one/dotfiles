#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

log_verbose() {
    echo -e "${BLUE}[DEBUG]${NC} $1"
}

# Execute command with verbose output
execute() {
    local cmd="$*"
    log_verbose "Executing: $cmd"
    eval "$cmd"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to check if path is a symlink
is_symlink() {
    [[ -L "$1" ]]
}

# Function to check if symlink points to our dotfiles
is_our_symlink() {
    local link="$1"
    local package="$2"
    local target
    if is_symlink "$link"; then
        target=$(readlink "$link")
        # Check if it points to the correct stow structure
        case "$package" in
            nvim)
                [[ "$target" == *"dotfiles/nvim/.config/nvim"* ]]
                ;;
            tmux)
                [[ "$target" == *"dotfiles/tmux/.tmux.conf"* ]]
                ;;
            ghostty)
                [[ "$target" == *"dotfiles/ghostty/.config/ghostty"* ]]
                ;;
            bash)
                [[ "$target" == *"dotfiles/bash/.bash_profile"* ]] || [[ "$target" == *"dotfiles/bash/.bashrc"* ]]
                ;;
            *)
                [[ "$target" == *"$DOTFILES_DIR"* ]] || [[ "$target" == *"dotfiles"* ]]
                ;;
        esac
    else
        return 1
    fi
}

# Function to install a package via Homebrew
install_brew_package() {
    local package=$1
    if brew list "$package" &>/dev/null; then
        log_success "$package is already installed"
    else
        log_info "Installing $package..."
        execute brew install "$package"
    fi
}

# Function to install a cask via Homebrew
install_brew_cask() {
    local cask=$1
    if brew list --cask "$cask" &>/dev/null 2>&1; then
        log_success "$cask is already installed"
    else
        log_info "Installing $cask..."
        execute brew install --cask "$cask"
    fi
}

# Function to handle existing files/symlinks - always backup and replace
handle_existing_path() {
    local path="$1"
    local package="$2"
    
    if [[ ! -e "$path" ]] && [[ ! -L "$path" ]]; then
        log_verbose "$path does not exist, safe to proceed"
        return 0
    fi
    
    if is_our_symlink "$path" "$package"; then
        log_info "$path is already a symlink to our dotfiles - will restow"
        return 0
    fi
    
    if is_symlink "$path"; then
        local target=$(readlink "$path")
        log_warning "$path is a symlink pointing to: $target"
        log_info "Removing old symlink..."
        execute rm "$path"
        log_success "Removed old symlink"
    else
        log_warning "$path exists and is not a symlink"
        local backup="${path}.backup.$(date +%Y%m%d_%H%M%S)"
        log_info "Backing up $path to $backup"
        execute mv "$path" "$backup"
        log_success "Backed up to $backup"
    fi
    
    return 0
}

# Function to stow a package - always force restow
stow_package() {
    local package="$1"
    local target_home="${2:-$HOME}"
    
    if [[ ! -d "$DOTFILES_DIR/$package" ]]; then
        log_warning "Package directory $package does not exist, skipping"
        return 1
    fi
    
    log_info "Processing $package..."
    
    # Determine what files would be created
    local stow_would_create=""
    
    case "$package" in
        nvim)
            stow_would_create="$target_home/.config/nvim"
            ;;
        tmux)
            stow_would_create="$target_home/.tmux.conf"
            ;;
        ghostty)
            stow_would_create="$target_home/.config/ghostty/config"
            ;;
        bash)
            # Handle multiple files for bash
            for file in "$target_home/.bash_profile" "$target_home/.bashrc"; do
                handle_existing_path "$file" "$package"
            done
            ;;
    esac
    
    # Check for conflicts (for non-bash packages)
    if [[ "$package" != "bash" ]] && [[ -n "$stow_would_create" ]]; then
        handle_existing_path "$stow_would_create" "$package"
    fi
    
    # Always unstow first (ignore errors) then restow
    log_verbose "Unstowing $package first (force mode)"
    stow -D "$package" -t "$target_home" 2>/dev/null || true
    
    log_info "Stowing $package..."
    if stow -v "$package" -t "$target_home" 2>&1 | while read -r line; do
            log_verbose "$line"
        done; then
        log_success "Successfully stowed $package"
    else
        log_error "Failed to stow $package"
        return 1
    fi
    
    return 0
}

# Main setup
echo "======================================"
echo "Dotfiles Setup Script"
echo "======================================"
echo "Directory: $DOTFILES_DIR"
echo "MODE: Auto-install with verbose output"
echo "======================================"
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "This script is designed for macOS. Please modify it for your OS."
    exit 1
fi

# Step 1: Install Homebrew if not present
log_info "Step 1: Checking Homebrew..."
if ! command_exists brew; then
    log_warning "Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    log_success "Homebrew installed"
else
    log_success "Homebrew is installed"
fi

# Step 2: Install GNU Stow
echo ""
log_info "Step 2: Installing required tools..."
install_brew_package "stow"
install_brew_package "git"

# Step 3: Fix old tmux.conf symlink if it points to the old location
echo ""
log_info "Step 3: Checking for old symlink structure..."

if is_symlink "$HOME/.tmux.conf"; then
    target=$(readlink "$HOME/.tmux.conf")
    if [[ "$target" == *"dotfiles/.tmux.conf" ]]; then
        log_warning "Found old tmux.conf symlink structure, fixing..."
        execute rm "$HOME/.tmux.conf"
        log_success "Removed old tmux.conf symlink"
    fi
fi

# Step 4: Install applications
echo ""
log_info "Step 4: Installing applications..."

# Neovim and dependencies
install_brew_package "neovim"
install_brew_package "ripgrep"
install_brew_package "fd"
install_brew_package "fzf"

# Tmux
install_brew_package "tmux"

# Ghostty (if available)
if brew search --casks "^ghostty$" &>/dev/null 2>&1; then
    install_brew_cask "ghostty"
else
    log_warning "Ghostty not available via Homebrew. Please install manually from https://ghostty.org"
fi

# Step 5: Create necessary directories
echo ""
log_info "Step 5: Creating directories..."
execute mkdir -p "$HOME/.config"

# Step 6: Stow bash configuration first (for environment setup)
echo ""
log_info "Step 6: Setting up bash configuration first..."

cd "$DOTFILES_DIR"

# Stow bash first to ensure environment variables are available
if [[ -d "bash" ]]; then
    stow_package "bash"
    
    # Source bash configuration if just installed
    if [[ -f "$HOME/.bash_profile" ]]; then
        log_info "Sourcing bash configuration..."
        source "$HOME/.bash_profile"
    fi
else
    log_verbose "Bash directory not found"
fi

# Step 7: Stow remaining configurations
echo ""
log_info "Step 7: Creating symlinks for remaining configurations..."

# Process remaining packages
for package in nvim tmux ghostty; do
    if [[ -d "$package" ]]; then
        stow_package "$package"
    else
        log_verbose "Skipping $package - directory not found"
    fi
done

# Step 8: Install and configure Tmux plugins
echo ""
log_info "Step 8: Setting up Tmux plugins..."

# Set TMUX_PLUGIN_MANAGER_PATH environment variable
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"

# Create plugin directory
execute mkdir -p "$TMUX_PLUGIN_MANAGER_PATH"

# Install TPM (Tmux Plugin Manager)
if [[ ! -d "$TMUX_PLUGIN_MANAGER_PATH/tpm" ]]; then
    log_info "Installing Tmux Plugin Manager..."
    execute git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_MANAGER_PATH/tpm"
    log_success "TPM installed"
    
    # Run TPM install script to install all plugins defined in .tmux.conf
    if [[ -f "$HOME/.tmux.conf" ]] && [[ -x "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins" ]]; then
        log_info "Installing plugins defined in .tmux.conf..."
        execute "TMUX_PLUGIN_MANAGER_PATH=$TMUX_PLUGIN_MANAGER_PATH $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins"
        log_success "Tmux plugins installed via TPM"
    fi
else
    log_success "TPM already installed"
    
    # Always update existing plugins
    if [[ -x "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins" ]]; then
        log_info "Updating existing tmux plugins..."
        execute "TMUX_PLUGIN_MANAGER_PATH=$TMUX_PLUGIN_MANAGER_PATH $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins all"
        log_success "Tmux plugins updated"
    fi
fi

# Reload tmux configuration if tmux is running
if command_exists tmux && tmux info &> /dev/null; then
    log_info "Reloading tmux configuration..."
    execute tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true
    
    # Also reload TPM
    if [[ -f "$TMUX_PLUGIN_MANAGER_PATH/tpm/tpm" ]]; then
        execute "TMUX_PLUGIN_MANAGER_PATH=$TMUX_PLUGIN_MANAGER_PATH tmux run-shell '$TMUX_PLUGIN_MANAGER_PATH/tpm/tpm'" 2>/dev/null || true
    fi
    
    log_success "Tmux configuration reloaded"
fi

# Step 9: Install language servers for Neovim
echo ""
log_info "Step 9: Installing language servers..."
install_brew_package "lua-language-server"
install_brew_package "typescript-language-server"
install_brew_package "node"

if command_exists npm; then
    log_info "Installing pyright via npm..."
    execute npm install -g pyright
fi

# Step 10: Verify installation
echo ""
log_info "Step 10: Verifying installation..."

verify_symlink() {
    local path="$1"
    local package="$2"
    
    if is_our_symlink "$path" "$package"; then
        log_success "$package is correctly linked"
        return 0
    elif [[ -e "$path" ]]; then
        log_warning "$package exists but is not linked to dotfiles"
        return 1
    else
        log_warning "$package is not installed"
        return 1
    fi
}

# Verify each package
verify_symlink "$HOME/.config/nvim" "nvim"
verify_symlink "$HOME/.tmux.conf" "tmux"
if [[ -d "$DOTFILES_DIR/ghostty" ]]; then
    verify_symlink "$HOME/.config/ghostty" "ghostty"
fi
if [[ -d "$DOTFILES_DIR/bash" ]]; then
    verify_symlink "$HOME/.bash_profile" "bash"
    verify_symlink "$HOME/.bashrc" "bash"
fi

# Verify tmux plugins
if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    log_success "TPM is installed"
    
    # Check for specific plugins
    if [[ -d "$HOME/.tmux/plugins/tmux" ]]; then
        log_success "Catppuccin tmux theme is installed"
    else
        log_warning "Catppuccin tmux theme not found - run prefix+I in tmux to install"
    fi
    
    if [[ -d "$HOME/.tmux/plugins/tmux-battery" ]]; then
        log_success "tmux-battery plugin is installed"
    else
        log_warning "tmux-battery plugin not found"
    fi
    
    if [[ -d "$HOME/.tmux/plugins/tmux-online-status" ]]; then
        log_success "tmux-online-status plugin is installed"
    else
        log_warning "tmux-online-status plugin not found"
    fi
else
    log_warning "TPM not installed - tmux plugins may not work"
fi

# Summary
echo ""
echo "======================================"
echo "✨ Setup complete! ✨"
echo "======================================"