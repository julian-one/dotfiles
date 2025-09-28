#!/bin/bash

# Core packages
echo "Installing core packages..."
sudo pacman -S --noconfirm --needed base-devel git wget less

# Development tools
echo "Installing development tools..."
sudo pacman -S --noconfirm --needed go nodejs npm tree-sitter-cli
sudo pacman -S --noconfirm --needed bash-completion fzf ripgrep fd

# Setup npm global packages directory
echo "Setting up npm global packages directory..."
if [ ! -d ~/.npm-global ]; then
    mkdir ~/.npm-global
fi
npm config set prefix '~/.npm-global'

# Add npm global to PATH if not already there
if ! grep -q "export PATH=~/.npm-global/bin:\$PATH" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# npm global packages" >> ~/.bashrc
    echo "export PATH=~/.npm-global/bin:\$PATH" >> ~/.bashrc
    echo "Added npm global path to ~/.bashrc"
fi

# Desktop environment
echo "Installing desktop environment packages..."
sudo pacman -S --noconfirm --needed waybar hyprpaper otf-font-awesome rofi

# Applications
echo "Installing applications..."
sudo pacman -S --noconfirm --needed firefox ghostty

# Audio setup (PipeWire stack)
echo "Setting up audio system..."
sudo pacman -S --noconfirm --needed pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
sudo pacman -S --noconfirm --needed alsa-utils pavucontrol

# Enable PipeWire services
systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
systemctl --user enable --now wireplumber.service

# Brightness control
echo "Installing brightness control..."
sudo pacman -S --noconfirm --needed brightnessctl

# Bluetooth support
echo "Setting up bluetooth..."
sudo pacman -S --noconfirm --needed bluez bluez-utils
sudo systemctl enable --now bluetooth.service

# Link bash configuration
echo "Setting up bash configuration..."
ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc
ln -sf ~/dotfiles/bash/.bash_profile ~/.bash_profile

# Setup ghostty
echo "Configuring ghostty terminal..."
if [ ! -d ~/.config/ghostty ]; then
    mkdir -p ~/.config/ghostty
fi
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config

# Install yay (AUR helper)
echo "Setting up AUR helper..."
if ! command -v yay &> /dev/null; then
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	makepkg -si --noconfirm
	cd
	rm -rf /tmp/yay
fi

# Install AUR packages
echo "Installing AUR packages..."
yay -S --needed neovim-nightly-bin
yay -S --needed blueberry
yay -S --needed 1password

# Link neovim config
echo "Setting up neovim configuration..."
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Link hyprland config
echo "Setting up hyprland configuration..."
rm -rf ~/.config/hypr
ln -sf ~/dotfiles/hypr/.config/hypr ~/.config/hypr

# Link waybar config
echo "Setting up waybar configuration..."
rm -rf ~/.config/waybar
ln -sf ~/dotfiles/waybar/.config/waybar ~/.config/waybar

# Link rofi config
echo "Setting up rofi configuration..."
rm -rf ~/.config/rofi
ln -sf ~/dotfiles/rofi/.config/rofi ~/.config/rofi

# Setup wallpaper
echo "Setting up wallpaper..."
if [ ! -d ~/Pictures ]; then
    mkdir -p ~/Pictures
fi
cp ~/dotfiles/wallpaper/wallpaper.jpg ~/Pictures/wallpaper.jpg

# Install custom font
echo "Installing custom font..."
FONT_NAME="ComicCodeLigaturesNerdFont.otf"
FONT_SOURCE="$HOME/dotfiles/fonts/$FONT_NAME"
FONT_DEST="/usr/share/fonts/truetype/nerdfonts/$FONT_NAME"

if [ ! -f "$FONT_DEST" ]; then
    echo "Installing Comic Code Nerd Font..."
    if [ ! -f "$FONT_SOURCE" ]; then
        echo "Error: Font file not found at $FONT_SOURCE"
        exit 1
    fi
    sudo mkdir -p /usr/share/fonts/truetype/nerdfonts
    sudo cp "$FONT_SOURCE" "$FONT_DEST"
    echo "Updating font cache..."
    sudo fc-cache -f 2>/dev/null
    echo "Font installed successfully."
else
    echo "Comic Code Nerd Font already installed, skipping..."
fi

# Link git configuration
echo "Setting up git configuration..."
if [ ! -d ~/.config/git ]; then
    mkdir -p ~/.config/git
fi
ln -sf ~/dotfiles/git/.config/git/config ~/.config/git/config
ln -sf ~/dotfiles/git/.config/git/work ~/.config/git/work
ln -sf ~/dotfiles/git/.config/git/ignore ~/.config/git/ignore

# Setup SSH for GitHub
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "Setting up SSH key for GitHub..."
    ssh-keygen -t ed25519 -C "julian-one@github" -f ~/.ssh/id_ed25519 -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo ""
    echo "========================================="
    echo "SSH PUBLIC KEY (Add this to GitHub):"
    echo "========================================="
    cat ~/.ssh/id_ed25519.pub
    echo "========================================="
    echo ""
    echo "Add the above key to: https://github.com/settings/keys"
    echo "Press Enter once you've added the key to continue..."
    read

    # Test SSH connection
    echo "Testing SSH connection to GitHub..."
    ssh -T git@github.com 2>&1 || true

    # Update remote to use SSH
    if [ -d ~/dotfiles/.git ]; then
        cd ~/dotfiles
        git remote set-url origin git@github.com:julian-one/dotfiles.git
        echo "Updated git remote to use SSH"
    fi
fi

echo ""
echo "========================================="
echo "Installation complete!"
echo "========================================="
echo "Please restart waybar or reload your session for changes to take effect."
