# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History 
HISTFILE="$HOME/.bash_history"
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# Prompt
PS1='[\u@\h \W]\$ '

# Editor
alias vim='nvim'
alias vi='nvim'

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
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
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
