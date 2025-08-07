# .zprofile
# Executed for login shells

# ======= Path Configuration =======
# Add common paths
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Homebrew paths (for Apple Silicon and Intel Macs)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ======= Environment Variables =======
# Default editor
export EDITOR=nvim
export VISUAL=nvim

# Pager
export PAGER=less
export LESS='-R'

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ======= Development Environment =======
# Node.js
export NODE_ENV=development

# Python
export PYTHONDONTWRITEBYTECODE=1  # Don't write .pyc files

# Go
export GOPATH="$HOME/go"

# Rust
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# ======= Terminal Settings =======
# Better ls colors for macOS
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Enable color support for various commands
export GREP_OPTIONS='--color=auto'

# ======= Application Settings =======
# Tmux plugin manager path
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"

# FZF configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 40% 
  --layout=reverse 
  --border 
  --info=inline
  --color=dark
  --color=fg:-1,bg:-1,hl:#5f87af
  --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
  --color=marker:#87ff00,spinner:#af5fff,header:#87afaf
'

# Ripgrep configuration
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# ======= XDG Base Directory Specification =======
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ======= Zsh Specific Settings =======
# History file location
export HISTFILE="$HOME/.zsh_history"

# Completion cache directory
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$HOST"

# ======= Security =======
# GPG TTY for signing commits
export GPG_TTY=$(tty)

# SSH Agent (if not already running)
if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" > /dev/null 2>&1
fi

# ======= Source .zshrc for interactive shells =======
# This ensures .zshrc is loaded for login shells too
if [[ -o interactive ]] && [[ -f ~/.zshrc ]]; then
    source ~/.zshrc
fi