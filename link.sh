#!/bin/sh
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
    mkdir -p ~/.config
    for dir in "$DOTFILES"/*/; do
        ln -sfn "$dir" ~/.config/"$(basename "$dir")"
    done
    ln -sf "$DOTFILES"/.zshrc ~/.zshrc
    echo "linked"
}

unlink() {
    for dir in "$DOTFILES"/*/; do
        target=~/.config/"$(basename "$dir")"
        [ -L "$target" ] && rm "$target"
    done
    [ -L ~/.zshrc ] && rm ~/.zshrc
    echo "unlinked"
}

case "$1" in
    -d) unlink ;;
    *)  link ;;
esac
