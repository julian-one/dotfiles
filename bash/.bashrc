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

# Enable extended globbing for completions
shopt -s extglob 2>/dev/null

# Enable bash completion - simple completions for bash 3.2 compatibility

# Simple git completion
if command -v git >/dev/null 2>&1; then
    complete -W "add branch checkout clone commit diff fetch init log merge pull push rebase reset status stash" git
fi

# Simple brew completion
if command -v brew >/dev/null 2>&1; then
    complete -W "install uninstall list search info update upgrade cleanup doctor --help" brew
fi

# Simple SSH completion for known hosts
if [[ -r ~/.ssh/known_hosts ]]; then
    complete -W "$(awk '{print $1}' ~/.ssh/known_hosts 2>/dev/null | cut -d, -f1 | sort -u)" ssh
fi

# Docker completion (if you use Docker)
if command -v docker >/dev/null 2>&1; then
    complete -W "run pull push build images ps stop start restart rm rmi exec logs inspect" docker
fi

# NPM completion (if you use Node.js)
if command -v npm >/dev/null 2>&1; then
    complete -W "install uninstall update run start test build init publish --save --save-dev --global" npm
fi

# Make completion (reads Makefile targets)
if command -v make >/dev/null 2>&1; then
    complete -W "$(make -qp 2>/dev/null | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /); for(i in A)print A[i]}' | sort -u 2>/dev/null)" make
fi

# Systemctl completion (if on Linux)
if command -v systemctl >/dev/null 2>&1; then
    complete -W "start stop restart reload status enable disable list-units" systemctl
fi

# Load local bashrc customizations if they exist
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

