# Exit if not running interactively
[[ $- != *i* ]] && return

# Options
shopt -s histappend checkwinsize

# History
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoreboth:erasedups

# LS_COLORS (Rose Pine)
LS_COLORS='di=38;2;196;167;231:ln=38;2;49;116;143:ex=38;2;235;111;146'
export LS_COLORS

# Prompt with git status
set_prompt() {
    PS1="\[\033[38;2;156;207;216m\]\w\[\033[0m\] "
    if git rev-parse --git-dir &>/dev/null; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        [[ -n $(git status --porcelain 2>/dev/null) ]] && branch+="*"
        PS1+="\[\033[38;2;196;167;231m\](${branch})\[\033[0m\] "
    fi
    PS1+="> "
}
PROMPT_COMMAND="set_prompt"

# Bash completion
if [[ $(uname -s) == "Darwin" ]]; then
    [[ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]] && source /opt/homebrew/etc/profile.d/bash_completion.sh
else
    [[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
fi

