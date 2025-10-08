# Bash Profile - System Environment Configuration

# PATH Configuration

# User binaries take precedence
export PATH="$HOME/.local/bin:$PATH"

export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# Default Applications

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=brave
export TERMINAL=ghostty

# XDG Base Directories

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Language-Specific Settings

export GOPATH="$HOME/go"

# Source bashrc for interactive shells
[[ -f ~/.bashrc ]] && source ~/.bashrc
