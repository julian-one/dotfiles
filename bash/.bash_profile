# PATH Configuration
add_to_path() {
    [[ -d "$1" ]] && export PATH="$1:$PATH"
}

add_to_path "$HOME/.local/bin"
add_to_path "/usr/local/go/bin"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/.npm-global/bin"

# Default Applications
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
fi
if command -v brave &>/dev/null; then
    export BROWSER=brave
fi
if command -v ghostty &>/dev/null; then
    export TERMINAL=ghostty
fi

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# Language-Specific Settings
export GOPATH="$HOME/go"

# Rust/Cargo environment
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Source bashrc for interactive shells
[[ -f ~/.bashrc ]] && source ~/.bashrc
