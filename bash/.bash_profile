# .bash_profile
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

# Go
export GOPATH="$HOME/go"

# Rust
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# ======= Application Settings =======
# FZF configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Ripgrep configuration
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# ======= XDG Base Directory Specification =======
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ======= Bash Specific Settings =======
# History file location
export HISTFILE="$HOME/.bash_history"

# ======= Security =======
# GPG TTY for signing commits
export GPG_TTY=$(tty)

# SSH Agent (if not already running)
if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" > /dev/null 2>&1
fi

# ======= Source .bashrc for interactive shells =======
# This ensures .bashrc is loaded for login shells too
if [[ $- == *i* ]] && [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
