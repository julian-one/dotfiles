[[ "$OSTYPE" == darwin* ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR=/opt/homebrew/bin/nvim

export PATH="$HOME/.local/bin:$PATH"
export PATH="$(npm get prefix -g)/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
