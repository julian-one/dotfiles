# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable command history
HISTSIZE=1000
HISTFILESIZE=2000

# Add local bin to PATH
export PATH="$HOME/bin:$PATH"

alias code='nvim'
