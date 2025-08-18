# Neovim Configuration

## Keybindings

**File Operations**
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>o` - Save & source
- `<leader>v` - Edit init.lua

**Navigation & Search**
- `<leader>f` - Fuzzy find files
- `<leader>g` - Live grep text in files
- `<leader>b` - Show open buffers
- `<leader>h` - Fuzzy find help
- `<leader>e` - Open file explorer
- `<leader>u` - Toggle undo tree
- `n` - Next search result (centered)
- `N` - Previous search result (centered)
- `<C-d>` - Half page down (centered)
- `<C-u>` - Half page up (centered)

**Buffer Management**
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer

**Window Management**
- `<C-h>` - Move to left window
- `<C-j>` - Move to bottom window
- `<C-k>` - Move to top window
- `<C-l>` - Move to right window
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<C-Up>` - Increase window height
- `<C-Down>` - Decrease window height
- `<C-Left>` - Decrease window width
- `<C-Right>` - Increase window width

**Text Editing**
- `<A-j>` - Move line down
- `<A-k>` - Move line up
- `<A-j>` (visual) - Move selection down
- `<A-k>` (visual) - Move selection up
- `<` (visual) - Indent left and reselect
- `>` (visual) - Indent right and reselect

**LSP**
- `gd` - Go to definition
- `gr` - References
- `gi` - Implementation
- `gt` - Type definition
- `K` - Hover info
- `<leader>ca` - Code actions
- `<leader>rn` - Rename
- `<leader>lf` - Format

**Diagnostics (Trouble)**
- `<leader>xx` - Toggle trouble diagnostics
- `<leader>xd` - Document diagnostics
- `<leader>xs` - Document symbols
- `<leader>xl` - Location list
- `<leader>xq` - Quickfix list

**System**
- `<leader>y` - Yank to clipboard
- `<leader>d` - Delete to clipboard
- `<leader>c` - Quick spell correction (first suggestion)

## Stack

**Languages**: Lua, Go, Svelte, TypeScript, TailwindCSS, Templ, HTML, CSS, JSON, YAML, Docker

**Plugins**: vague.nvim, oil.nvim, mini.pick, nvim-treesitter, nvim-lspconfig, mason.nvim, blink.cmp, trouble.nvim