# Path (Yellow Brick Road) 
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# Environment 
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=brave
export TERMINAL=ghostty

# XDG Stuff 
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Language(s)
export GOPATH="$HOME/go"

# SSH
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Source .bashrc for interactive shells
[[ -f ~/.bashrc ]] && source ~/.bashrc
