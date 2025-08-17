# Simple Dotfiles Makefile
DOTFILES_DIR := $(shell pwd)

# Default target
all: install link

# Install packages
install:
	@echo "Installing packages..."
	@if command -v brew >/dev/null 2>&1; then \
		brew install stow git neovim ripgrep fd fzf tree-sitter gnupg; \
		brew install --cask ghostty; \
	else \
		echo "Please install Homebrew first"; \
		exit 1; \
	fi
	@echo "✓ Packages installed"

# Create symlinks
link:
	@echo "Creating symlinks..."
	@mkdir -p ~/.config
	@ln -sf $(DOTFILES_DIR)/bash/.bashrc ~/.bashrc
	@ln -sf $(DOTFILES_DIR)/bash/.bash_profile ~/.bash_profile
	@ln -sf $(DOTFILES_DIR)/git/.gitconfig ~/.gitconfig
	@ln -sf $(DOTFILES_DIR)/nvim/.config/nvim ~/.config/nvim
	@ln -sf $(DOTFILES_DIR)/ghostty ~/.config/ghostty
	@if [ -d "$(DOTFILES_DIR)/fonts" ]; then \
		cp $(DOTFILES_DIR)/fonts/*.otf ~/Library/Fonts/ 2>/dev/null || true; \
	fi
	@echo "✓ Symlinks created"

# Remove symlinks
clean:
	@echo "Removing symlinks..."
	@rm -f ~/.bashrc ~/.bash_profile ~/.gitconfig
	@rm -rf ~/.config/nvim ~/.config/ghostty
	@echo "✓ Symlinks removed"

# Verify installation
verify:
	@echo "Verifying installation..."
	@for tool in git nvim rg fd fzf; do \
		if command -v $$tool >/dev/null 2>&1; then \
			echo "✓ $$tool installed"; \
		else \
			echo "✗ $$tool missing"; \
		fi; \
	done
	@for link in ~/.bashrc ~/.gitconfig ~/.config/nvim; do \
		if [ -L "$$link" ]; then \
			echo "✓ $$link linked"; \
		else \
			echo "✗ $$link not linked"; \
		fi; \
	done

# Show help
help:
	@echo "Available targets:"
	@echo "  all     - Install packages and create symlinks"
	@echo "  install - Install packages via Homebrew"
	@echo "  link    - Create configuration symlinks"
	@echo "  clean   - Remove symlinks"
	@echo "  verify  - Verify installation"
	@echo "  help    - Show this help"

.PHONY: all install link clean verify help