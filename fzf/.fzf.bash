# FZF Configuration

# Default command - use fd for better filtering
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude node_modules --exclude .cache --exclude .npm --exclude .local/share --exclude .cargo --exclude .rustup --exclude go/pkg'

# Apply same filtering when using CTRL-T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview files with bat, directories with tree
export FZF_CTRL_T_OPTS="
  --preview 'bat --color=always --style=numbers --line-range=:500 {}'
  --bind 'ctrl-/:toggle-preview'
  --preview-window right:60%:wrap"

# ALT-C options - directory navigation
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git --exclude node_modules --exclude .cache'
export FZF_ALT_C_OPTS="
  --preview 'tree -C {} | head -50'
  --preview-window right:50%"

# Default fzf options
export FZF_DEFAULT_OPTS="
  --height 60%
  --layout=reverse
  --border
  --info=inline
  --multi
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-a:select-all'
  --bind 'ctrl-d:deselect-all'
  --bind 'ctrl-e:execute(nvim {} < /dev/tty)'
  --color=fg:#c5cdd9,bg:#252530,hl:#6e94b2
  --color=fg+:#c5cdd9,bg+:#32323e,hl+:#bb9dbd
  --color=info:#bb9dbd,prompt:#6e94b2,pointer:#bb9dbd
  --color=marker:#6e94b2,spinner:#bb9dbd,header:#6e94b2"