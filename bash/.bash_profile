# .bash_profile
# Executed for login shells

# Suppress zsh default shell warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Source bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Add common paths
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Set default editor
export EDITOR=nvim
export VISUAL=nvim

# History settings
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups

# Better ls colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Tmux plugin manager path
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"

# Enable extended globbing for completions
shopt -s extglob 2>/dev/null

# Enable bash completion (required for login shells)
if ! shopt -oq posix; then
    # Simple completion setup - individual files loaded in .bashrc
    :
fi
