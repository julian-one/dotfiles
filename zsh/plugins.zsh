BREW_PREFIX="$(brew --prefix)"

fpath+="$BREW_PREFIX/share/zsh-completions"
fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit && compinit

source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
