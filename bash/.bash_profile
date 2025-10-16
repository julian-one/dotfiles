# Source bashrc for interactive shells
[[ -f ~/.bashrc ]] && source ~/.bashrc

# PATH
add_to_path() { [[ -d "$1" ]] && PATH="$1:$PATH"; }
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"
add_to_path "/usr/local/go/bin"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/.npm-global/bin"
export PATH

# Environment
export EDITOR=nvim VISUAL=nvim BROWSER=firefox TERMINAL=ghostty

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
