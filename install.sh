sudo pacman -S --noconfirm --needed go git wget less firefox waybar base-devel 
sudo pacman -S --noconfirm --needed nodejs npm unzip tree-sitter-cli otf-font-awesome

# Install ghostty
sudo pacman -S --noconfirm --needed ghostty
if [ ! -d ~/.config/ghostty ]; then
    mkdir -p ~/.config/ghostty
fi
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config

# Install yay
if ! command -v yay &> /dev/null; then
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	makepkg -si --noconfirm
	cd
	rm -rf /tmp/yay
fi

# Install neovim
yay -S --needed neovim-nightly-bin
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Link hyprland config
rm -rf ~/.config/hypr
ln -sf ~/dotfiles/hypr/.config/hypr ~/.config/hypr

# Link waybar config
rm -rf ~/.config/waybar
ln -sf ~/dotfiles/waybar/.config/waybar ~/.config/waybar

# Install font
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

# Setup SSH for GitHub 
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "Setting up SSH key for GitHub..."
    ssh-keygen -t ed25519 -C "julian-one@github" -f ~/.ssh/id_ed25519 -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo "SSH public key (add this to GitHub):"
    cat ~/.ssh/id_ed25519.pub
    echo ""
    echo "Add the above key to: https://github.com/settings/keys"
    echo "Press Enter once you've added the key to continue..."
    read

    # Test SSH connection
    ssh -T git@github.com 2>&1 || true

    # Update remote to use SSH
    if [ -d ~/dotfiles/.git ]; then
        cd ~/dotfiles
        git remote set-url origin git@github.com:julian-one/dotfiles.git
    fi
fi

sudo pacman -S --noconfirm --needed bluez bluez-utils 
yay -S --needed blueberry 
sudo systemctl enable --now bluetooth.service

sudo pacman -S --noconfirm --needed pavucontrol hyprpaper
