# .bashrc
# Executed for non-login shells

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Better history handling
shopt -s histappend
shopt -s checkwinsize

# Custom prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Enable color support for ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Enable bash completion
if ! shopt -oq posix; then
    # Check for bash-completion@2 (Homebrew)
    if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
        . "/opt/homebrew/etc/profile.d/bash_completion.sh"
    elif [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
        . "/usr/local/etc/profile.d/bash_completion.sh"
    # Fallback to system bash completion if available
    elif [[ -f /etc/bash_completion ]] && ! [[ "$OSTYPE" =~ ^darwin ]]; then
        . /etc/bash_completion
    fi
fi

# Load additional completion files manually if bash-completion isn't available
if ! command -v _completion_loader &> /dev/null; then
    # Git completion (if available)
    [[ -r "/usr/local/etc/bash_completion.d/git-completion.bash" ]] && . "/usr/local/etc/bash_completion.d/git-completion.bash"
    [[ -r "/opt/homebrew/etc/bash_completion.d/git-completion.bash" ]] && . "/opt/homebrew/etc/bash_completion.d/git-completion.bash"
    
    # Homebrew completion
    [[ -r "/usr/local/etc/bash_completion.d/brew" ]] && . "/usr/local/etc/bash_completion.d/brew"
    [[ -r "/opt/homebrew/etc/bash_completion.d/brew" ]] && . "/opt/homebrew/etc/bash_completion.d/brew"
fi

# Load local bashrc customizations if they exist
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

