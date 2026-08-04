# Path & env — brew prefix differs on Apple Silicon vs Intel
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [ -x "$brew" ] && eval "$("$brew" shellenv)" && break
done
unset brew

export EDITOR=nvim
export MANPAGER='nvim +Man!'

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify

# Prompt
autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats ' %b'
setopt prompt_subst
PROMPT='%F{green}%1~%f%F{244}${vcs_info_msg_0_}%f %# '

# Completions & plugins
fpath+="$HOMEBREW_PREFIX/share/zsh-completions"
autoload -Uz compinit && compinit

source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
