#!/bin/bash

open_session() {
  local name=$1

  case $name in
    citadel) local path="$HOME/trading-spaces/citadel"; local server="go run . serve" ;;
    shire)   local path="$HOME/trading-spaces/shire";   local server="npm run dev" ;;
  esac

  if ! tmux has-session -t "$name" 2>/dev/null; then
    tmux new-session -d -s "$name" -n "editor"
    tmux send-keys -t "$name:editor" "cd $path && nvim ." C-m

    tmux new-window -t "$name" -n "server"
    tmux send-keys -t "$name:server" "cd $path && $server" C-m

    tmux select-window -t "$name:editor"
  fi

  tmux attach-session -t "$name"
}

case $1 in
  citadel|shire) open_session "$1" ;;
  "") tmux choose-session ;;
  *) echo "unknown project: $1"; exit 1 ;;
esac
