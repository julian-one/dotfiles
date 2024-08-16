export BASH_SILENCE_DEPRECATION_WARNING=1

eval "$(/usr/local/bin/brew shellenv)"

export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/Users/julian-one/Downloads/templ_Darwin_x86_64
export PATH=$PATH:$(go env GOPATH)/bin

alias templ='/Users/julian-one/Downloads/templ_Darwin_x86_64/templ'
alias vim='nvim'
