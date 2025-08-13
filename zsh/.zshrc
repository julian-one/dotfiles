# ================================================================================================
# Minimal Zsh Configuration - Built-in Features Only
# Matches minimal Neovim philosophy: essential functionality, default appearance
# ================================================================================================

# Essential options
setopt AUTO_CD               # cd by typing directory name
setopt AUTO_PUSHD            # Make cd push directories onto dir stack  
setopt PUSHD_IGNORE_DUPS     # Don't push duplicates onto dir stack
setopt EXTENDED_GLOB         # Use extended globbing syntax
setopt INTERACTIVE_COMMENTS  # Allow comments in interactive mode
setopt NO_BEEP              # Don't beep on error

# History - built-in only
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS      # Don't record duplicates
setopt HIST_IGNORE_SPACE     # Don't record entries starting with space
setopt INC_APPEND_HISTORY    # Write to history file immediately
setopt SHARE_HISTORY         # Share history between sessions

# Built-in completion system only
autoload -Uz compinit
compinit

# Key bindings - built-in emacs mode
bindkey -e
bindkey "^[[H" beginning-of-line    # Home
bindkey "^[[F" end-of-line          # End  
bindkey "^[[3~" delete-char         # Delete
bindkey "^[[1;5C" forward-word      # Ctrl+Right
bindkey "^[[1;5D" backward-word     # Ctrl+Left

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

# Simple prompt with git - default colors only
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' [%b]'

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Simple prompt - default appearance
PROMPT='%n:%~$vcs_info_msg_0_
❯ '