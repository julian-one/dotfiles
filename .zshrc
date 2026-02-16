# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="minimal"
plugins=(git golang docker npm kubectl zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
source $ZSH/oh-my-zsh.sh

# History
HISTFILE=~/.zsh_history          # where to save history
HISTSIZE=10000                   # max entries in memory
SAVEHIST=10000                   # max entries in file
setopt append_history            # append instead of overwrite
setopt share_history             # share history across sessions
setopt hist_ignore_dups          # ignore consecutive duplicates
setopt hist_ignore_space         # ignore commands starting with space
setopt hist_expire_dups_first    # expire duplicates first when trimming
setopt hist_find_no_dups         # skip duplicates during search
setopt hist_verify               # show command before executing from history

# Vim
bindkey -v                       # enable vi keybindings
KEYTIMEOUT=1                     # reduce mode switch delay (1 = 10ms)
bindkey '^Y' autosuggest-accept  # accept suggestion with Ctrl+Y

# Editor
export EDITOR=/usr/bin/nvim

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$(npm get prefix -g)/bin:$PATH"
