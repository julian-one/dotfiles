# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History Configuration (optimized for Hyprland)
HISTFILE="$HOME/.bash_history"
HISTSIZE=50000                      # More in-memory history
HISTFILESIZE=100000                  # Larger history file
HISTCONTROL=ignoreboth:erasedups    # Ignore dups and spaces
HISTIGNORE="ls:ll:cd:pwd:exit:date:* --help"  # Ignore common commands
shopt -s histappend                  # Append to history, don't overwrite
shopt -s cmdhist                     # Store multi-line commands as one
PROMPT_COMMAND="history -a; history -c; history -r"  # Sync history across terminals

# Better history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history'

# FZF history function for better searching
__fzf_history() {
    local selected
    selected=$(history | fzf --tac --no-sort --query="$READLINE_LINE" | sed 's/^[ ]*[0-9]*[ ]*//')
    READLINE_LINE="$selected"
    READLINE_POINT=${#READLINE_LINE}
}

# Colors from Vague theme
COLOR_RESET='\[\033[0m\]'
COLOR_RED='\[\033[38;2;216;100;126m\]'      # #d8647e
COLOR_GREEN='\[\033[38;2;127;165;99m\]'     # #7fa563
COLOR_YELLOW='\[\033[38;2;243;190;124m\]'   # #f3be7c
COLOR_BLUE='\[\033[38;2;110;148;178m\]'     # #6e94b2
COLOR_PURPLE='\[\033[38;2;187;157;189m\]'   # #bb9dbd
COLOR_CYAN='\[\033[38;2;174;174;209m\]'     # #aeaed1
COLOR_GRAY='\[\033[38;2;96;96;121m\]'       # #606079
COLOR_WHITE='\[\033[38;2;205;205;205m\]'    # #cdcdcd

# Git branch function
git_branch() {
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}

# Git status indicators
git_status() {
    if [[ -n $(git status -s 2>/dev/null) ]]; then
        echo "*"
    fi
}

# Command status indicator
set_prompt() {
    local last_exit=$?
    local status_color=""
    local status_symbol=""

    if [[ $last_exit -eq 0 ]]; then
        status_color=$COLOR_GREEN
        status_symbol="›"
    else
        status_color=$COLOR_RED
        status_symbol="›"
    fi

    # Build the prompt
    PS1=""

    # Current directory in yellow
    PS1+="${COLOR_YELLOW}\w "

    # Git branch if in a git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        PS1+="${COLOR_PURPLE}($(git_branch)$(git_status)) "
    fi

    # Status symbol
    PS1+="${status_color}${status_symbol}${COLOR_RESET} "
}

# Set the prompt command
PROMPT_COMMAND="set_prompt; history -a; history -c; history -r"

# Editor
alias vim='nvim'
alias vi='nvim'

# Aliases with color support
alias ls='ls --color=auto'
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Hyprland shortcuts
alias hc='$EDITOR ~/.config/hypr/hyprland.conf'
alias hr='hyprctl reload'

# Brave browser - disable KDE wallet integration
alias brave='brave --password-store=basic'

# Bash Completion 
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
[ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
