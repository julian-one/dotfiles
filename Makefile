# Dotfiles Management Makefile
# Cross-platform compatible for macOS (Intel/Apple Silicon) and Arch Linux

SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
UNAME_M := $(shell uname -m)
UNAME_S := $(shell uname -s)

# OS Detection and Package Manager Setup
ifeq ($(UNAME_S),Darwin)
	OS := macOS
	# Homebrew path detection for macOS
	ifeq ($(UNAME_M),arm64)
		BREW_PREFIX := /opt/homebrew
	else
		BREW_PREFIX := /usr/local
	endif
	PKG_MANAGER := brew
	HAS_YAY := false
else ifeq ($(UNAME_S),Linux)
	OS := Linux
	PKG_MANAGER := pacman
	# Check if yay is available for AUR packages
	HAS_YAY := $(shell command -v yay >/dev/null 2>&1 && echo true || echo false)
	# Set plugin paths for Arch Linux
	ZSH_PLUGIN_PATH := /usr/share/zsh/plugins
else
	OS := Unknown
	$(error Unsupported operating system: $(UNAME_S))
endif

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m

# Helper functions
define log_info
	echo -e "$(BLUE)[INFO]$(NC) $(1)"
endef

define log_success
	echo -e "$(GREEN)[✓]$(NC) $(1)"
endef

define log_warning
	echo -e "$(YELLOW)[⚠]$(NC) $(1)"
endef

define log_error
	echo -e "$(RED)[✗]$(NC) $(1)"
endef

# Font configuration
FONT_SOURCE := $(DOTFILES_DIR)/fonts
ifeq ($(OS),macOS)
	FONT_DIR := $(HOME)/Library/Fonts
else ifeq ($(OS),Linux)
	FONT_DIR := $(HOME)/.local/share/fonts
endif

# Package lists per OS
ifeq ($(OS),macOS)
	CORE_PACKAGES := stow git neovim ripgrep fd fzf lua-language-server node go stylua black shfmt clang-format
	BREW_PACKAGES := typescript-language-server gopls vscode-langservers-extracted yaml-language-server tailwindcss-language-server prettier sql-formatter bash-language-server typos-lsp golangci-lint eslint
	CASK_PACKAGES := ghostty
else ifeq ($(OS),Linux)
	# Core packages available in official repos
	CORE_PACKAGES := stow git neovim ripgrep fd fzf nodejs npm go prettier clang
	# AUR packages (if yay is available)
	AUR_PACKAGES := lua-language-server typescript-language-server gopls vscode-langservers-extracted yaml-language-server tailwindcss-language-server sql-formatter bash-language-server typos-lsp stylua black shfmt golangci-lint eslint
	# Applications from repos or AUR
	APP_PACKAGES := 
	AUR_APP_PACKAGES := ghostty
endif

# Default target
.PHONY: all
all: install stow verify
	@$(call log_success,"Dotfiles setup complete!")

# Install package managers if needed
.PHONY: setup-package-manager
setup-package-manager:
ifeq ($(OS),macOS)
	@$(call log_info,"Checking Homebrew installation...")
	@if ! command -v brew >/dev/null 2>&1; then \
		echo -e "$(YELLOW)[⚠]$(NC) Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		if [ -f "$(BREW_PREFIX)/bin/brew" ]; then \
			echo 'eval "$$($(BREW_PREFIX)/bin/brew shellenv)"' >> ~/.zprofile; \
			eval "$$($(BREW_PREFIX)/bin/brew shellenv)"; \
		fi; \
		echo -e "$(GREEN)[✓]$(NC) Homebrew installed"; \
	else \
		echo -e "$(GREEN)[✓]$(NC) Homebrew already installed"; \
	fi
else ifeq ($(OS),Linux)
	@$(call log_info,"Checking package manager setup...")
	@if ! command -v pacman >/dev/null 2>&1; then \
		echo -e "$(RED)[✗]$(NC) pacman not found. This script is designed for Arch Linux."; \
		exit 1; \
	fi
	@if ! command -v yay >/dev/null 2>&1; then \
		echo -e "$(YELLOW)[⚠]$(NC) yay not found. Installing yay for AUR access..."; \
		sudo pacman -S --needed base-devel git; \
		git clone https://aur.archlinux.org/yay.git /tmp/yay; \
		cd /tmp/yay && makepkg -si --noconfirm; \
		rm -rf /tmp/yay; \
		echo -e "$(GREEN)[✓]$(NC) yay installed"; \
	else \
		echo -e "$(GREEN)[✓]$(NC) yay already installed"; \
	fi
endif

# Install all packages
.PHONY: install
install: setup-package-manager install-packages install-apps install-fonts install-npm-packages install-go-packages

.PHONY: install-packages
install-packages:
ifeq ($(OS),macOS)
	@$(call log_info,"Installing Homebrew core packages...")
	@for package in $(CORE_PACKAGES); do \
		if brew list $$package >/dev/null 2>&1; then \
			echo -e "$(GREEN)[✓]$(NC) $$package already installed"; \
		else \
			echo -e "$(BLUE)[INFO]$(NC) Installing $$package..."; \
			brew install $$package; \
		fi; \
	done
	@$(call log_info,"Installing additional Homebrew packages...")
	@for package in $(BREW_PACKAGES); do \
		if brew list $$package >/dev/null 2>&1; then \
			echo -e "$(GREEN)[✓]$(NC) $$package already installed"; \
		else \
			echo -e "$(BLUE)[INFO]$(NC) Installing $$package..."; \
			brew install $$package; \
			if ! brew link $$package >/dev/null 2>&1; then \
				echo -e "$(YELLOW)[⚠]$(NC) Force linking $$package..."; \
				brew link --overwrite $$package >/dev/null 2>&1; \
			fi; \
		fi; \
	done
else ifeq ($(OS),Linux)
	@$(call log_info,"Installing core packages...")
	@sudo pacman -S --needed --noconfirm $(CORE_PACKAGES) 2>/dev/null || \
		for package in $(CORE_PACKAGES); do \
			if pacman -Qi $$package >/dev/null 2>&1; then \
				echo -e "$(GREEN)[✓]$(NC) $$package already installed"; \
			else \
				echo -e "$(BLUE)[INFO]$(NC) Installing $$package..."; \
				sudo pacman -S --needed --noconfirm $$package; \
			fi; \
		done
	@if [ "$(HAS_YAY)" = "true" ] && [ -n "$(AUR_PACKAGES)" ]; then \
		echo -e "$(BLUE)[INFO]$(NC) Installing AUR packages..."; \
		for package in $(AUR_PACKAGES); do \
			if yay -Qi $$package >/dev/null 2>&1; then \
				echo -e "$(GREEN)[✓]$(NC) $$package already installed"; \
			else \
				echo -e "$(BLUE)[INFO]$(NC) Installing $$package from AUR..."; \
				yay -S --needed --noconfirm $$package; \
			fi; \
		done; \
	fi
endif


.PHONY: install-apps
install-apps:
ifeq ($(OS),macOS)
	@$(call log_info,"Installing applications via Homebrew casks...")
	@for cask in $(CASK_PACKAGES); do \
		if brew list --cask $$cask >/dev/null 2>&1; then \
			echo -e "$(GREEN)[✓]$(NC) $$cask already installed"; \
		else \
			if brew search --casks "^$$cask$$" >/dev/null 2>&1; then \
				echo -e "$(BLUE)[INFO]$(NC) Installing $$cask..."; \
				brew install --cask $$cask; \
			else \
				echo -e "$(YELLOW)[⚠]$(NC) $$cask not available via Homebrew"; \
			fi; \
		fi; \
	done
else ifeq ($(OS),Linux)
	@$(call log_info,"Installing applications...")
	@if [ -n "$(APP_PACKAGES)" ]; then \
		sudo pacman -S --needed --noconfirm $(APP_PACKAGES); \
	fi
	@if [ "$(HAS_YAY)" = "true" ] && [ -n "$(AUR_APP_PACKAGES)" ]; then \
		echo -e "$(BLUE)[INFO]$(NC) Installing AUR applications..."; \
		for package in $(AUR_APP_PACKAGES); do \
			if yay -Qi $$package >/dev/null 2>&1; then \
				echo -e "$(GREEN)[✓]$(NC) $$package already installed"; \
			else \
				echo -e "$(BLUE)[INFO]$(NC) Installing $$package from AUR..."; \
				yay -S --needed --noconfirm $$package; \
			fi; \
		done; \
	fi
endif

.PHONY: install-fonts
install-fonts:
	@$(call log_info,"Installing Comic Code fonts...")
	@if [ -d "$(FONT_SOURCE)" ]; then \
		mkdir -p "$(FONT_DIR)"; \
		for font in "$(FONT_SOURCE)"/*.otf; do \
			if [ -f "$$font" ]; then \
				font_name=$$(basename "$$font"); \
				if [ -f "$(FONT_DIR)/$$font_name" ]; then \
					echo -e "$(GREEN)[✓]$(NC) $$font_name already installed"; \
				else \
					echo -e "$(BLUE)[INFO]$(NC) Installing $$font_name..."; \
					cp "$$font" "$(FONT_DIR)/"; \
					echo -e "$(GREEN)[✓]$(NC) $$font_name installed"; \
				fi; \
			fi; \
		done; \
	else \
		echo -e "$(YELLOW)[⚠]$(NC) Comic Code font source not found at $(FONT_SOURCE)"; \
		echo -e "$(YELLOW)[⚠]$(NC) Skipping font installation"; \
	fi
ifeq ($(OS),Linux)
	@if [ -d "$(FONT_SOURCE)" ]; then \
		echo -e "$(BLUE)[INFO]$(NC) Rebuilding font cache..."; \
		fc-cache -f -v >/dev/null 2>&1; \
		echo -e "$(GREEN)[✓]$(NC) Font cache rebuilt"; \
	fi
endif


.PHONY: install-npm-packages
install-npm-packages:
	@$(call log_info,"Installing npm packages...")
	@if command -v npm >/dev/null 2>&1; then \
		for package in pyright svelte-language-server; do \
			if npm list -g $$package >/dev/null 2>&1; then \
				echo -e "$(GREEN)[✓]$(NC) $$package already installed"; \
			else \
				echo -e "$(BLUE)[INFO]$(NC) Installing $$package..."; \
				npm install -g $$package; \
			fi; \
		done; \
		echo -e "$(GREEN)[✓]$(NC) npm packages installed"; \
	else \
		echo -e "$(YELLOW)[⚠]$(NC) npm not available, skipping npm packages"; \
	fi

.PHONY: install-go-packages
install-go-packages:
	@$(call log_info,"Installing Go packages...")
	@if command -v go >/dev/null 2>&1; then \
		for tool in templ goimports gofumpt golines; do \
			case $$tool in \
				templ) \
					if ! command -v templ >/dev/null 2>&1; then \
						echo -e "$(BLUE)[INFO]$(NC) Installing templ..."; \
						go install github.com/a-h/templ/cmd/templ@latest; \
					else \
						echo -e "$(GREEN)[✓]$(NC) templ already installed"; \
					fi \
					;; \
				goimports) \
					if ! command -v goimports >/dev/null 2>&1; then \
						echo -e "$(BLUE)[INFO]$(NC) Installing goimports..."; \
						go install golang.org/x/tools/cmd/goimports@latest; \
					else \
						echo -e "$(GREEN)[✓]$(NC) goimports already installed"; \
					fi \
					;; \
				gofumpt) \
					if ! command -v gofumpt >/dev/null 2>&1; then \
						echo -e "$(BLUE)[INFO]$(NC) Installing gofumpt..."; \
						go install mvdan.cc/gofumpt@latest; \
					else \
						echo -e "$(GREEN)[✓]$(NC) gofumpt already installed"; \
					fi \
					;; \
				golines) \
					if ! command -v golines >/dev/null 2>&1; then \
						echo -e "$(BLUE)[INFO]$(NC) Installing golines..."; \
						go install github.com/segmentio/golines@latest; \
					else \
						echo -e "$(GREEN)[✓]$(NC) golines already installed"; \
					fi \
					;; \
			esac; \
		done; \
		echo -e "$(GREEN)[✓]$(NC) All Go tools installed"; \
	else \
		echo -e "$(YELLOW)[⚠]$(NC) go not available, skipping Go tools"; \
	fi

# Create symlinks using absolute paths (similar to your current script)
.PHONY: stow
stow: create-dirs stow-configs

.PHONY: create-dirs
create-dirs:
	@$(call log_info,"Creating necessary directories...")
	@mkdir -p ~/.config ~/.config/zsh ~/.config/git

.PHONY: stow-configs
stow-configs:
	@$(call log_info,"Creating configuration symlinks...")
	@cd $(DOTFILES_DIR) && \
	for package in bash git nvim ghostty; do \
		if [ -d "$$package" ]; then \
			echo -e "$(BLUE)[INFO]$(NC) Linking $$package configuration..."; \
			$(MAKE) stow-$$package; \
		else \
			echo -e "$(YELLOW)[⚠]$(NC) $$package directory not found, skipping"; \
		fi; \
	done

.PHONY: stow-bash
stow-bash:
	@rm -f ~/.bashrc ~/.bash_profile ~/.profile 2>/dev/null || true
	@ln -sf $(DOTFILES_DIR)/bash/.bashrc ~/.bashrc
	@ln -sf $(DOTFILES_DIR)/bash/.bash_profile ~/.bash_profile
	@$(call log_success,"Bash configuration linked")

.PHONY: stow-git
stow-git:
	@rm -f ~/.gitconfig ~/.config/git/work.gitconfig 2>/dev/null || true
	@ln -sf $(DOTFILES_DIR)/git/.gitconfig ~/.gitconfig
	@if [ -f "$(DOTFILES_DIR)/git/work.gitconfig" ]; then \
		ln -sf $(DOTFILES_DIR)/git/work.gitconfig ~/.config/git/work.gitconfig; \
	fi
	@$(call log_success,"Git configuration linked")

.PHONY: stow-nvim
stow-nvim:
	@rm -rf ~/.config/nvim 2>/dev/null || true
	@ln -sf $(DOTFILES_DIR)/nvim/.config/nvim ~/.config/nvim
	@$(call log_success,"Neovim configuration linked")


.PHONY: stow-ghostty
stow-ghostty:
	@rm -rf ~/.config/ghostty 2>/dev/null || true
	@ln -sf $(DOTFILES_DIR)/ghostty ~/.config/ghostty
	@$(call log_success,"Ghostty configuration linked")

# Verification
.PHONY: verify
verify:
	@$(call log_info,"Verifying installation...")
	@$(MAKE) verify-links
	@$(MAKE) verify-tools

.PHONY: verify-links
verify-links:
	@for link in ~/.bashrc ~/.bash_profile ~/.gitconfig ~/.config/nvim; do \
		if [ -L "$$link" ] && [ -e "$$link" ]; then \
			echo -e "$(GREEN)[✓]$(NC) $$link is correctly linked"; \
		else \
			echo -e "$(YELLOW)[⚠]$(NC) $$link is missing or not linked"; \
		fi; \
	done
	@if [ -d "$(DOTFILES_DIR)/ghostty" ] && [ -L ~/.config/ghostty ]; then \
		echo -e "$(GREEN)[✓]$(NC) ~/.config/ghostty is correctly linked"; \
	fi

.PHONY: verify-tools
verify-tools:
	@for tool in git stow nvim; do \
		if command -v $$tool >/dev/null 2>&1; then \
			$(call log_success,"$$tool is available"); \
		else \
			$(call log_error,"$$tool is not available"); \
		fi; \
	done
ifeq ($(OS),macOS)
	@if command -v brew >/dev/null 2>&1; then \
		$(call log_success,"brew is available"); \
	else \
		$(call log_error,"brew is not available"); \
	fi
else ifeq ($(OS),Linux)
	@if command -v pacman >/dev/null 2>&1; then \
		$(call log_success,"pacman is available"); \
	else \
		$(call log_error,"pacman is not available"); \
	fi
	@if command -v yay >/dev/null 2>&1; then \
		$(call log_success,"yay is available"); \
	else \
		$(call log_warning,"yay is not available (AUR packages may not be installed)"); \
	fi
endif

# Cleanup and uninstall
.PHONY: clean
clean:
	@$(call log_info,"Removing symlinks...")
	@rm -f ~/.bashrc ~/.bash_profile ~/.gitconfig 2>/dev/null || true
	@rm -rf ~/.config/nvim ~/.config/ghostty 2>/dev/null || true
	@$(call log_success,"Symlinks removed")

.PHONY: info
info:
	@echo "System Information:"
	@echo "  OS: $(OS) ($(UNAME_S))"
	@echo "  Architecture: $(UNAME_M)"
	@echo "  Package Manager: $(PKG_MANAGER)"
ifeq ($(OS),macOS)
	@echo "  Homebrew prefix: $(BREW_PREFIX)"
else ifeq ($(OS),Linux)
	@echo "  Has yay: $(HAS_YAY)"
	@echo "  Zsh plugins path: $(ZSH_PLUGIN_PATH)"
endif
	@echo "  Dotfiles directory: $(DOTFILES_DIR)"

# Help target
.PHONY: help
help:
	@echo "Dotfiles Management Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  all              - Full setup (install + stow + verify)"
	@echo "  install          - Install all packages and dependencies"
	@echo "  stow            - Create configuration symlinks"
	@echo "  verify          - Verify installation and links"
	@echo "  clean           - Remove all symlinks"
	@echo "  info            - Show system information"
	@echo "  help            - Show this help message"
	@echo ""
	@echo "Individual targets:"
	@echo "  setup-package-manager - Install package manager"
	@echo "  install-packages - Install core packages"
	@echo "  install-apps    - Install applications"
	@echo "  install-fonts   - Install Comic Code fonts"
	@echo "  stow-bash       - Link bash configuration"
	@echo "  stow-git        - Link git configuration"
	@echo "  stow-nvim       - Link neovim configuration"
	@echo "  stow-ghostty    - Link ghostty configuration"
	@echo ""
	@echo "OS-specific targets:"
ifeq ($(OS),macOS)
	@echo "  setup-package-manager - Install Homebrew"
else ifeq ($(OS),Linux)
	@echo "  setup-package-manager - Install yay (AUR helper)"
endif