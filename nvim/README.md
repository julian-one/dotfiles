# Neovim Configuration

Minimal, fast Neovim setup optimized for modern development with LSP, completion, and fuzzy finding.

## 🚀 Quick Start

This config is designed to work immediately with zero additional setup. All plugins and LSP servers are configured to install automatically.

**Leader Key**: `<Space>`

## ⌨️ Essential Keybindings

### 📁 File Operations
| Key | Action | Use Case |
|-----|--------|----------|
| `<leader>w` | Save file | Quick save |
| `<leader>q` | Quit | Close buffer/window |
| `<leader>o` | Save & source | Reload config after changes |
| `<leader>v` | Edit init.lua | Quick config access |

### 🔍 Navigation & Search
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>f` | **Fuzzy find files** | Most important! Find any file in project |
| `<leader>g` | **Live grep** | Search text across all files |
| `<leader>b` | Buffer list | Switch between open files |
| `<leader>h` | Help search | Search Neovim documentation |
| `<leader>e` | **File explorer** | Browse project structure |

### 🔧 LSP Powers
| Key | Action | What It Does |
|-----|--------|--------------|
| `gd` | Go to definition | Jump to function/variable definition |
| `gr` | Go to references | See all usages |
| `gi` | Go to implementation | Jump to implementation |
| `gt` | Go to type definition | Jump to type definition |
| `K` | Hover info | Show documentation/type info |
| `<leader>ca` | Code actions | Quick fixes and refactoring |
| `<leader>rn` | Rename symbol | Rename across entire project |
| `<leader>lf` | **Format code** | Auto-format current file |

### 📋 System Integration
| Key | Action | Why It's Useful |
|-----|--------|-----------------|
| `<leader>y` | Yank to clipboard | Copy to system clipboard |
| `<leader>d` | Delete to clipboard | Cut to system clipboard |
| `<leader>c` | Quick spell fix | Apply first spelling suggestion |

### ✨ Completion
| Key | Action | In Insert Mode |
|-----|--------|----------------|
| `<Tab>` | Accept completion | Accept highlighted suggestion |
| `<C-n>` | Next completion | Navigate down |
| `<C-p>` | Previous completion | Navigate up |
| `<Esc>` | Cancel completion | Dismiss menu |

---

## 🎯 Workflow Examples

### Opening Files
1. `<leader>f` → Type partial filename → `<Enter>`
2. `<leader>e` → Navigate with `j/k` → `<Enter>`

### Finding Text
1. `<leader>g` → Type search term → `<Enter>` to jump to match

### Code Navigation
1. Put cursor on function name → `gd` to see definition
2. `gr` to see all places it's used
3. `K` to see documentation

### Editing Code
1. `<leader>ca` for quick fixes
2. `<leader>rn` to rename variables/functions
3. `<leader>lf` to format code

---

## 🛠️ Included Plugins

### Core Functionality
- **blink.cmp** - Fast completion engine with LSP integration
- **mini.pick** - Fuzzy finder for files, buffers, and text
- **oil.nvim** - Edit filesystem like a buffer
- **vague.nvim** - Clean, minimal colorscheme

### Language Support
- **nvim-lspconfig** - LSP configurations
- **mason.nvim** - LSP server installer
- **nvim-treesitter** - Syntax highlighting and parsing

### Supported Languages
- **Go** (gopls)
- **TypeScript/JavaScript** (ts_ls)
- **Svelte** (svelte)
- **HTML/CSS** (html, cssls)
- **JSON/YAML** (jsonls, yamlls)
- **Docker** (dockerls)
- **Templ** (templ)
- **Lua** (lua_ls)

---

## 💡 Vim Essentials

### Movement
- `h j k l` - Left, Down, Up, Right
- `w/b` - Word forward/backward
- `0/$` - Line start/end
- `gg/G` - File start/end

### Editing
- `i/a` - Insert before/after cursor
- `o/O` - New line below/above
- `x` - Delete character
- `dd` - Delete line
- `yy` - Copy line
- `p` - Paste

### Visual Mode
- `v` - Select characters
- `V` - Select lines
- `<C-v>` - Select block

---

## 🔧 Customization

### Adding LSP Servers
Add to the `vim.lsp.enable()` list in `init.lua`:
```lua
vim.lsp.enable({
    "your_language_server"
})
```

### Changing Keymaps
Add to `init.lua`:
```lua
map('n', '<your_key>', '<your_command>')
```

### Installing New Plugins
Add to the `vim.pack.add()` section:
```lua
{ src = "https://github.com/author/plugin" }
```

## 🚨 Troubleshooting

### LSP Not Working
1. Run `:Mason` to install language servers
2. Check `:LspInfo` for connection status
3. Ensure your project has proper file types

### Completion Not Showing
1. Verify LSP is running with `:LspInfo`
2. Check if you're in insert mode
3. Try typing more characters to trigger completion

### Files Not Found
1. Ensure you're in a project directory
2. Check if files exist with `<leader>e`
3. Try `:Pick files` directly


