# NeoVim Key Mappings Reference

Essential keybindings for navigating and editing in Neovim. The configuration uses minimal plugins with maximum built-in functionality.

## Essential Key Mappings

**Leader Key: `<Space>`**

### Core Movement & Navigation
- `n/N` - Next/previous search result (centered)
- `<C-d>/<C-u>` - Half page down/up (centered)
- `<C-h/j/k/l>` - Move between windows
- `J` - Join lines and keep cursor position

### File Operations
- `<leader>e` - Open file explorer (netrw)
- `<leader>ff` - Find file with `:find`
- `<leader>rc` - Edit config file
- `<leader>pa` - Copy current file path to clipboard

### Terminal
- `<leader>t` - Toggle floating terminal
- `<Esc>` (in terminal) - Close floating terminal

### Tabs & Buffers
- `<leader>tn` - New tab
- `<leader>tx` - Close current tab
- `<leader>td` - Duplicate current tab
- `<leader>tr` - Close tabs to the right
- `<leader>tL` - Close tabs to the left
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Smart close buffer/tab

### Window Management
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<C-Up/Down>` - Resize window height
- `<C-Left/Right>` - Resize window width

### Editing & Formatting
- `<A-j>/<A-k>` - Move line/selection up/down
- `</>` (visual) - Indent left/right and reselect
- `<leader>d` - Delete without yanking
- `<leader>fm` - Format current file
- `<leader>c` - Clear search highlights

### Quick File Navigation (Harpoon)
- `<leader>ma` - Add current file to harpoon
- `<leader>mm` - Toggle harpoon menu
- `<leader>m1-4` - Jump to harpoon file 1-4

### LSP (Language Server Protocol)
- `gD` - Go to definition
- `gs` - Go to declaration
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Hover documentation
- `<C-k>` - Signature help
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

### Diagnostics
- `<leader>nd` - Next diagnostic
- `<leader>pd` - Previous diagnostic
- `<leader>d` - Open diagnostic float
- `<leader>q` - Open diagnostic quickfix list (current buffer only)
- `:Diagnostics` - Show all project diagnostics in quickfix list

### Quickfix & Location Lists
- `<leader>qo` - Open quickfix list
- `<leader>qc` - Close quickfix list
- `<leader>qn/qp` - Next/previous quickfix item
- `<leader>qf/ql` - First/last quickfix item
- `<leader>lo/lc` - Open/close location list
- `<leader>ln/lp` - Next/previous location item

### Registers & Clipboard
- `<leader>r` - Show all registers
- `<leader>y` - Yank to system clipboard
- `<leader>p` - Paste from system clipboard
- `"ay` - Yank to register 'a'
- `"ap` - Paste from register 'a'

### Advanced Search & Replace
- `<leader>sr` - Replace word under cursor
- `<leader>sa` - Replace in all open buffers
- `<leader>sr` (visual) - Replace in selection

## Idiomatic Neovim Tips

### Essential Vim Motions
- `w/b` - Word forward/backward
- `e` - End of word
- `0/$` - Beginning/end of line
- `gg/G` - Top/bottom of file
- `f/F + char` - Find character forward/backward
- `t/T + char` - Till character forward/backward
- `%` - Jump to matching bracket

### Text Objects
- `ciw` - Change inner word
- `caw` - Change around word
- `ci"` - Change inside quotes
- `ca"` - Change around quotes
- `cip` - Change inner paragraph
- `ci)` - Change inside parentheses

### Visual Mode
- `v` - Character-wise visual
- `V` - Line-wise visual
- `<C-v>` - Block-wise visual
- `o` - Jump to other end of selection

### Search & Replace Patterns
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n/N` - Next/previous search result
- `*/#` - Search word under cursor forward/backward
- `:%s/old/new/g` - Replace all in file
- `:%s/old/new/gc` - Replace all with confirmation
- `:s/old/new/g` - Replace all in current line
- `:'<,'>s/old/new/g` - Replace in visual selection
- `:g/pattern/s/old/new/g` - Replace in lines matching pattern
- `:bufdo %s/old/new/g | update` - Replace in all buffers

### Advanced Search Tips
- `/\<word\>` - Search for exact word (word boundaries)
- `/\cpattern` - Case insensitive search
- `/\Cpattern` - Case sensitive search
- `/pattern\|other` - Search for pattern OR other
- `:noh` or `<leader>c` - Clear search highlights

### Registers (Vim's Clipboard System)
- `"` - Default register (last yank/delete)
- `"0` - Yank register (last yanked text)
- `"1-9` - Delete registers (last 9 deletions)
- `"+` - System clipboard register
- `"*` - Selection register (X11 systems)
- `"a-z` - Named registers (lowercase)
- `"A-Z` - Append to named registers (uppercase)
- `"_` - Black hole register (delete without saving)
- `"/` - Last search register
- `":` - Last command register

### Register Usage Examples
- `"ayy` - Yank line to register 'a'
- `"ap` - Paste from register 'a'
- `"Ayy` - Append line to register 'a'
- `"_dd` - Delete line without storing
- `"+p` - Paste from system clipboard
- `<C-r>a` - Insert register 'a' in insert mode
- `<C-r>/` - Insert last search in command mode

### Quickfix List Workflow
- `:make` - Run make and populate quickfix
- `:grep pattern **/*.js` - Search files and populate quickfix
- `:vimgrep /pattern/g %` - Search current file
- `:copen` - Open quickfix window
- `:cnext/:cprev` - Navigate items
- `:cfirst/:clast` - Jump to first/last
- `:cc N` - Jump to item N
- `:cdo s/old/new/g` - Replace in all quickfix items

### Location List vs Quickfix
- **Quickfix**: Global, shared across all windows
- **Location List**: Local to current window
- Use `:l` commands instead of `:c` for location lists
- `:lgrep`, `:lopen`, `:lnext`, etc.

### Quick Commands & Macros
- `.` - Repeat last command
- `u` - Undo
- `<C-r>` - Redo
- `qa` - Start recording macro in register 'a'
- `q` - Stop recording macro
- `@a` - Execute macro from register 'a'
- `@@` - Repeat last macro
- `>>/<< ` - Indent/unindent line

## Common Workflows

### Project-Wide Search & Replace
1. `:grep "oldtext" **/*.js` - Find all occurrences
2. `:copen` - Open quickfix list to review
3. `:cdo %s/oldtext/newtext/g | update` - Replace in all files

### Working with Multiple Files
1. `:args **/*.go` - Add Go files to argument list
2. `:argdo %s/old/new/g | update` - Replace in all argument files
3. `:bufdo %s/old/new/g | update` - Replace in all open buffers

### Git Integration Workflow
1. `:!git grep "pattern"` - Search in git repository
2. Use quickfix navigation to jump between results
3. Git branch shown in statusline for context

### Effective Register Usage
1. `"ayy` - Save important lines to named registers
2. `"by5j` - Yank 5 lines to register 'b'
3. `"ap` / `"bp` - Paste from specific registers
4. `<leader>r` - View all registers when needed

## Native File Finding with `:find`

The `<leader>ff` mapping uses Vim's powerful built-in `:find` command, which searches through your `path` setting.

### How `:find` Works
- **Pattern Matching**: `:find` accepts glob patterns and partial filenames
- **Tab Completion**: Press `<Tab>` after `:find` to see available matches
- **Fuzzy-like**: You can match partial paths and filenames
- **No Plugin Required**: Pure Vim functionality

### `:find` Examples
```vim
:find init.lua          " Find exact filename
:find *init*            " Find any file containing 'init'
:find **/*config*       " Search recursively for files with 'config'
:find src/**/*.js       " Find JS files in src/ subdirectories
:find **/routes/*.go    " Find Go files in any routes/ directory
:find *.md              " Find all Markdown files in current directory
```

### Path Configuration
Your config sets `vim.opt.path:append("**")` which enables:
- **Recursive Search**: Searches all subdirectories from current working directory
- **Project-Wide Finding**: Works across entire project structure
- **Fast Performance**: Native implementation, no external dependencies

### `:find` vs File Explorers
**Advantages:**
- ✅ Blazing fast - no plugin overhead
- ✅ Powerful pattern matching with glob support
- ✅ Tab completion shows available matches
- ✅ Works in any project without configuration
- ✅ Remembers recently used patterns

**Usage Tips:**
1. **Start typing and press `<Tab>`** to see completions
2. **Use `*` wildcards** for flexible matching
3. **Press `<C-d>`** to see all possible completions
4. **Use `**`** for recursive directory searches

### How to Use `:find` Step-by-Step

**Basic Usage:**
1. Press `<leader>ff` (Space + f + f)
2. Type partial filename or pattern
3. Press `<Tab>` to see completions
4. Press `<Enter>` to open the file

**Practical Examples:**

**Finding Configuration Files:**
```vim
<leader>ff
:find *config*<Tab>     " Shows: config.js, tailwind.config.js, etc.
```

**Finding Components in React/Svelte:**
```vim
<leader>ff  
:find **/Button*<Tab>   " Shows: components/Button.svelte, ui/Button.tsx
```

**Finding Route Files:**
```vim
<leader>ff
:find **/route*<Tab>    " Shows: src/routes/+page.svelte, api/routes/users.go
```

**Finding Test Files:**
```vim
<leader>ff
:find *test*<Tab>       " Shows: user.test.js, routes_test.go
```

**Pro Tips:**
- **Partial matching**: Type `but` finds `Button.vue` or `aboutus.html`
- **Multiple patterns**: `:find **/*user*.{js,ts}` finds user files in JS/TS
- **Case insensitive**: Most systems ignore case by default
- **Recent files**: Press `<Up>` arrow to recall previous `:find` patterns

### Alternative File Navigation
- `<leader>e` - Native file explorer (netrw)
- `<leader>ff` - Find files with `:find` + tab completion  
- `:e path/to/file` - Direct file opening
- `gf` - Go to file under cursor
- `<C-^>` - Switch to alternate file

### Why `:find` is Better Than File Trees
- **Faster**: No scrolling through directory trees
- **Keyboard-driven**: No mouse required
- **Memory efficient**: No constant directory listing
- **Project-aware**: Automatically searches entire project
- **Predictable**: Same behavior in any project