# Bash Configuration - Interactive Shell

# Exit if not running interactively
[[ $- != *i* ]] && return

# Shell Options

# Better directory navigation
shopt -s autocd                         # Auto-cd when entering just a path
shopt -s cdspell                        # Autocorrect typos in path names
shopt -s dirspell                       # Autocorrect directory names in completion
shopt -s cdable_vars                    # cd into variables

# Improved globbing
shopt -s nocaseglob                     # Case-insensitive globbing
shopt -s globstar                       # Enable ** for recursive directory matching
shopt -s dotglob                        # Include dotfiles in pathname expansion

# Better shell behavior
shopt -s checkwinsize                   # Update LINES and COLUMNS after each command
shopt -s no_empty_cmd_completion        # No completion on empty line

# History Configuration

# History file settings
HISTFILE="$HOME/.bash_history"
HISTSIZE=50000                          # Commands in memory
HISTFILESIZE=100000                     # Commands in history file
HISTCONTROL=ignoreboth:erasedups        # Ignore duplicates and leading spaces

# Don't save common/trivial commands
HISTIGNORE="ls:ll:la:cd:pwd:exit:clear:history:* --help"

# Shell options for better history handling
shopt -s histappend                     # Append to history, don't overwrite
shopt -s cmdhist                        # Save multi-line commands as one entry

# Enhanced History Navigation

# Arrow keys search history based on what you've typed
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Ctrl+R for FZF history search
bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history'

# FZF-powered history search function
__fzf_history() {
    local selected
    selected=$(history | fzf --tac --no-sort --query="$READLINE_LINE" | sed 's/^[ ]*[0-9]*[ ]*//')
    READLINE_LINE="$selected"
    READLINE_POINT=${#READLINE_LINE}
}


# Git Prompt Helpers

# Get current git branch name
git_branch() {
    git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}

# Get git repository status indicators
git_status_info() {
    local status=$(git status --porcelain 2>/dev/null) || return
    [[ -z "$status" ]] && return

    local m=0 a=0 d=0 u=0
    while IFS= read -r line; do
        case "$line" in
            ' M'*) ((m++)) ;;
            'A'*) ((a++)) ;;
            'D'*) ((d++)) ;;
            '??'*) ((u++)) ;;
        esac
    done <<< "$status"

    local out=""
    ((m)) && out+="~$m"
    ((a)) && out+="+$a"
    ((d)) && out+="-$d"
    ((u)) && out+="?$u"
    [[ -n "$out" ]] && echo " $out"
}

# Dynamic Prompt Builder
set_prompt() {
    # Start building prompt
    PS1=""

    # Current directory
    PS1+="\w "

    # Git information (if in a repository)
    if git rev-parse --git-dir &>/dev/null; then
        local branch=$(git_branch)
        local git_info=$(git_status_info)
        PS1+="(${branch}${git_info}) "
    fi

    # Prompt character
    PS1+="> "
}

# Update prompt before each command
PROMPT_COMMAND="set_prompt; history -a; history -c; history -r"

# Editor Aliases

alias vim='nvim'
alias vi='nvim'

# Shell Enhancements

# Enable programmable completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

# FZF integration
for fzf_file in ~/.fzf.bash /usr/share/fzf/shell/key-bindings.bash; do
    [[ -f "$fzf_file" ]] && source "$fzf_file"
done

