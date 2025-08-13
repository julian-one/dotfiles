# ================================================================================================
# Minimal Bash Configuration - Built-in Features Only
# Matches minimal Neovim philosophy: essential functionality, default appearance
# ================================================================================================

# Suppress macOS zsh deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Essential shell options (only for bash)
if [[ "$BASH_VERSION" ]]; then
    set -o emacs                  # Emacs-style command line editing
    shopt -s cdspell             # Correct minor spelling errors in cd commands
    shopt -s checkwinsize        # Check window size after each command
    
    # Enable newer bash features if available
    shopt -s direxpand 2>/dev/null   # Expand directory names during tab completion
    shopt -s autocd 2>/dev/null      # cd by typing directory name (Bash 4.0+)
    shopt -s globstar 2>/dev/null    # Enable ** for recursive globbing (Bash 4.0+)
fi

# History - built-in only
HISTFILE="$HOME/.bash_history"
HISTSIZE=1000
HISTFILESIZE=1000
if [[ "$BASH_VERSION" ]]; then
    shopt -s histappend          # Append to history file, don't overwrite
fi
export HISTCONTROL=ignoredups:ignorespace  # Don't record duplicates or entries starting with space

# Key bindings - built-in emacs mode (only for bash)
if [[ "$BASH_VERSION" ]]; then
    bind '"\e[H": beginning-of-line'    # Home
    bind '"\e[F": end-of-line'          # End
    bind '"\e[3~": delete-char'         # Delete
    bind '"\e[1;5C": forward-word'      # Ctrl+Right
    bind '"\e[1;5D": backward-word'     # Ctrl+Left
fi

# Essential aliases only
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'

# Git shortcuts (most common)
alias gs='git status'
alias ga='git add'
alias gc='git commit' 
alias gl='git log --oneline'
alias gd='git diff'

# Simple function
mkcd() { mkdir -p "$1" && cd "$1"; }

# Simple git-aware prompt
git_branch() {
    git branch 2>/dev/null | grep '^*' | cut -d' ' -f2- | sed 's/^/ [/' | sed 's/$/]/'
}

# Simple prompt - default appearance
PS1='\u:\w$(git_branch)\n❯ '