# FZF Configuration - Simplified

# Basic file search - exclude common directories
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.git/*" -not -path "*/node_modules/*" 2>/dev/null'

# Use same command for CTRL-T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Simple preview with less (no external deps)
export FZF_CTRL_T_OPTS="--preview 'head -100 {}' --preview-window=right:50%"

# Directory navigation with ALT-C
export FZF_ALT_C_COMMAND='find . -type d -not -path "*/\.git/*" -not -path "*/node_modules/*" 2>/dev/null'
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

# Clean default options
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border
  --multi
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-e:execute(nvim {})'
  --bind='enter:execute(nvim {})'
"