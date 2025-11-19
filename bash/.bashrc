# Exit if not running interactively
[[ $- != *i* ]] && return

# Shell Options
shopt -s cdspell 2>/dev/null
shopt -s cdable_vars 2>/dev/null
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend
shopt -s cmdhist

if ((BASH_VERSINFO[0] >= 4)); then
    shopt -s autocd 2>/dev/null
    shopt -s dirspell 2>/dev/null
    shopt -s globstar 2>/dev/null
fi

# Rose Pine ls colors
# shellcheck source=/dev/null
[[ -f ~/.ls_colors ]] && source ~/.ls_colors

# History Configuration
HISTFILE="$HOME/.bash_history"
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:ll:la:cd:pwd:exit:clear:history:* --help"

# History Navigation
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

if command -v fzf &>/dev/null; then
    bind '"\C-r": "\C-x1\e^\er"'
    bind -x '"\C-x1": __fzf_history'
    __fzf_history() {
        local selected
        selected=$(history | fzf --tac --no-sort --query="$READLINE_LINE" 2>/dev/null | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]*//')
        if [[ -n "$selected" ]]; then
            READLINE_LINE="$selected"
            READLINE_POINT=${#READLINE_LINE}
        fi
    }
fi

# Git Helpers
git_branch() {
    git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}

git_status_info() {
    local status
    status=$(git status --porcelain 2>/dev/null) || return
    [[ -z "$status" ]] && return

    local m=0 a=0 d=0 u=0
    while IFS= read -r line; do
        case "${line:0:2}" in
            ' M'|'M '|'MM') ((m++)) ;;
            'A '|'AM') ((a++)) ;;
            ' D'|'D '|'DM'|'AD') ((d++)) ;;
            '??') ((u++)) ;;
        esac
    done <<< "$status"

    local out=""
    ((m)) && out+="~$m"
    ((a)) && out+="+$a"
    ((d)) && out+="-$d"
    ((u)) && out+="?$u"
    [[ -n "$out" ]] && echo " $out"
}

# Rose Pine Prompt
COLOR_FOAM="\[\033[38;2;156;207;216m\]"
COLOR_IRIS="\[\033[38;2;196;167;231m\]"
COLOR_GOLD="\[\033[38;2;246;193;119m\]"
COLOR_TEXT="\[\033[38;2;224;222;244m\]"
COLOR_RESET="\[\033[0m\]"

set_prompt() {
    PS1="${COLOR_FOAM}\w${COLOR_RESET} "
    if git rev-parse --git-dir &>/dev/null; then
        local branch
        local git_info
        branch=$(git_branch)
        git_info=$(git_status_info)
        PS1+="${COLOR_IRIS}(${branch}${COLOR_RESET}${COLOR_GOLD}${git_info}${COLOR_IRIS})${COLOR_RESET} "
    fi
    PS1+="${COLOR_TEXT}>${COLOR_RESET} "
}

PROMPT_COMMAND="set_prompt; history -a"

# Aliases
alias vim='nvim'
alias vi='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -h'
alias df='df -h'
alias mkdir='mkdir -pv'

# Linux-specific ls aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'
alias lt='ls -lhtr'
alias lS='ls -lhSr'

# Linux-specific preserve-root
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Bash completion
# shellcheck source=/dev/null
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
fi

# FZF integration
# shellcheck source=/dev/null
for fzf_file in ~/.fzf.bash /usr/share/fzf/shell/key-bindings.bash; do
    [[ -f "$fzf_file" ]] && source "$fzf_file"
done

