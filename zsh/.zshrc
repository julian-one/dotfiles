# .zshrc
# Executed for interactive shells

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ======= Zsh Options =======
setopt AUTO_CD              # cd by typing directory name
setopt AUTO_PUSHD           # Make cd push directories onto dir stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates onto dir stack
setopt PUSHD_MINUS          # Exchange meaning of + and - for pushd
setopt CDABLE_VARS          # Change directory to a path stored in a variable
setopt EXTENDED_GLOB        # Use extended globbing syntax
setopt GLOB_DOTS            # Include dotfiles in globbing
setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode
setopt NO_BEEP              # Don't beep on error
setopt CORRECT              # Command correction
setopt CORRECT_ALL          # Argument correction

# ======= History Configuration =======
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_FIND_NO_DUPS         # Don't display duplicates during searches
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_VERIFY               # Don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions

# ======= Completion System =======
# Add custom completions directory to fpath
fpath=(~/.config/zsh/completions $fpath)

# Initialize completion system in background for faster startup
{
  autoload -Uz compinit
  # Check for insecure directories and compile zcompdump once per day
  if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
    compinit
  else
    compinit -C
  fi
  
  # Load bash completion compatibility if available
  autoload -Uz bashcompinit && bashcompinit
  
  # Load Homebrew completions if available
  if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    # Rebuild completion cache
    rehash
  fi
} &!

# Completion options
setopt COMPLETE_IN_WORD    # Complete from both ends of a word
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word
setopt PATH_DIRS           # Perform path search even on command names with slashes
setopt AUTO_MENU           # Show completion menu on a successive tab press
setopt AUTO_LIST           # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash
setopt MENU_COMPLETE       # Cycle through completions with tab
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'  # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"                       # Colorize completions
zstyle ':completion:*' menu select                                             # Highlight current selection
zstyle ':completion:*' group-name ''                                           # Group completions by type
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'              # Format descriptions
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' verbose yes                                             # Verbose completion

# Better completion for kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Cache completions
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

# ======= Key Bindings =======
bindkey -e  # Use emacs key bindings

# Home/End keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Delete key
bindkey "^[[3~" delete-char

# Word navigation
bindkey "^[[1;5C" forward-word   # Ctrl+Right
bindkey "^[[1;5D" backward-word  # Ctrl+Left

# ======= Aliases =======
# File listing
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -ltr'  # Sort by modification time
alias lh='ls -lh'   # Human readable sizes

# Grep coloring
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Directory stack navigation (zsh specific)
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Git aliases
alias git='nocorrect git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gpl='git pull'
alias gst='git stash'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Zsh specific aliases
alias history='fc -l 1'
alias h='history'
alias hs='history | grep'

# Global aliases (zsh specific - can be used anywhere in command)
alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'

# ======= Functions =======
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ======= Plugin Management =======
# Load zsh-syntax-highlighting if installed
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Load zsh-autosuggestions if installed
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load zsh-history-substring-search if installed
if [[ -f /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    # Bind keys for history substring search after plugin loads
    bindkey '^[[A' history-substring-search-up     # Up arrow
    bindkey '^[[B' history-substring-search-down   # Down arrow
    bindkey '^P' history-substring-search-up       # Ctrl+P
    bindkey '^N' history-substring-search-down     # Ctrl+N
elif [[ -f /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    # Bind keys for history substring search after plugin loads
    bindkey '^[[A' history-substring-search-up     # Up arrow
    bindkey '^[[B' history-substring-search-down   # Down arrow
    bindkey '^P' history-substring-search-up       # Ctrl+P
    bindkey '^N' history-substring-search-down     # Ctrl+N
else
    # Fallback to standard history search if plugin not available
    bindkey '^[[A' up-line-or-history     # Up arrow
    bindkey '^[[B' down-line-or-history   # Down arrow
fi

# ======= FZF Integration =======
# Load fzf in background for faster startup
{
  if [[ -f ~/.fzf.zsh ]]; then
      source ~/.fzf.zsh
  elif command -v fzf &> /dev/null; then
      # Setup fzf key bindings and fuzzy completion
      eval "$(fzf --zsh)" 2>/dev/null || true
  fi
} &!

# ======= Load local customizations =======
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# ======= Prompt Configuration =======
# Load powerlevel10k theme if installed
if [[ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
else
    # Fallback to a simple prompt if p10k not available
    autoload -Uz promptinit && promptinit
    PROMPT='%F{blue}%n@%m%f:%F{green}%~%f$ '
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh