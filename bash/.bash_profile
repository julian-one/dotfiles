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

# Enable bash completion (required for login shells)
if ! shopt -oq posix; then
    # Check for bash-completion@2 (Homebrew)
    if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
        . "/opt/homebrew/etc/profile.d/bash_completion.sh"
    elif [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
        . "/usr/local/etc/profile.d/bash_completion.sh"
    fi
fi
