# Suppress macOS zsh deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Essential shell options (only for bash)
if [[ "$BASH_VERSION" ]]; then
    set -o vi                     # Vi-style command line editing
    shopt -s cdspell             # Correct minor spelling errors in cd commands
    shopt -s checkwinsize        # Check window size after each command
    
    # Enable newer bash features if available
    shopt -s direxpand 2>/dev/null   # Expand directory names during tab completion
    shopt -s autocd 2>/dev/null      # cd by typing directory name (Bash 4.0+)
    shopt -s globstar 2>/dev/null    # Enable ** for recursive globbing (Bash 4.0+)
fi

# Enhanced History Management
HISTFILE="$HOME/.bash_history"
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="[%F %T] "        # Add timestamps to history
if [[ "$BASH_VERSION" ]]; then
    shopt -s histappend          # Append to history file, don't overwrite
    shopt -s histverify          # Verify history expansions before executing
fi
export HISTCONTROL=ignoredups:ignorespace:erasedups  # Remove duplicates across entire history

# Key bindings - vi mode (only for bash)
if [[ "$BASH_VERSION" ]]; then
    # Vi mode indicator in prompt (optional)
    bind 'set show-mode-in-prompt on'
    # Essential navigation bindings that work in vi mode
    bind '"\e[H": beginning-of-line'    # Home
    bind '"\e[F": end-of-line'          # End
    bind '"\e[3~": delete-char'         # Delete
fi

# File and Directory Operations
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'          # Create parent dirs and be verbose

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gl='git log --oneline'
alias gll='git log --graph --pretty=format:"%C(yellow)%h%C(reset) - %C(blue)%an%C(reset), %C(green)%cr%C(reset) : %s"'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch'
alias gco='git checkout'
alias gp='git push'
alias gpl='git pull'

# Utility Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'                 # Human readable disk usage
alias du='du -h'                 # Human readable directory sizes
alias free='free -h'             # Human readable memory usage (Linux)
alias path='echo $PATH | tr ":" "\n"'  # Show PATH in readable format

# Faster git branch detection for prompt
git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        echo " [$branch]"
    fi
}

# Simple prompt
PS1='\u:\w$(git_branch) \$ '
