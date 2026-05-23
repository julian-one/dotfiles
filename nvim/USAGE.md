# Neovim usage guide

A practical reference for this configuration. Covers layout, keymaps grouped
by prefix, plugin workflows, and maintenance.

---

## 1. Overview

- **Plugin manager:** Neovim 0.11+ native `vim.pack` (no lazy.nvim, no packer).
- **LSP:** Native `vim.lsp.config` via per-server files under `nvim/lsp/`,
  binaries installed by `mason-tool-installer`, enabled via `vim.lsp.enable()`.
- **Completion:** `blink.cmp` with LSP, snippets, buffer, path sources.
- **Treesitter:** main branch with textobjects + sticky context.
- **Format on save:** `conform.nvim`.
- **Leader:** `Space`. `maplocalleader` is also `Space`.

---

## 2. File layout

```
nvim/
  init.lua                       -- entry: requires options, keymaps, plugins, autocmds, terminal, clean
  lua/
    options.lua                  -- vim.opt.* (must load first)
    keymaps.lua                  -- global, non-LSP keymaps
    diagnostics.lua              -- diagnostic UI + jump keymaps
    autocmds.lua                 -- yank highlight, cursor restore, comment-continuation off
    terminal.lua                 -- :Floaterminal + <leader>tt
    clean.lua                    -- :<leader>cu  remove unused packed plugins
    plugins/
      init.lua                   -- vim.pack.add({...}) + load order
      icons.lua                  -- nvim-web-devicons (loaded first)
      noice.lua                  -- cmdline / messages / notifications / LSP progress
      treesitter.lua             -- treesitter core + textobjects + context
      lsp.lua                    -- mason chain + vim.lsp.enable + LspAttach
      completion.lua             -- blink.cmp
      autopairs.lua              -- nvim-autopairs
      surround.lua               -- nvim-surround
      formatting.lua             -- conform.nvim
      undotree.lua               -- mbbill/undotree
      oil.lua                    -- file explorer (stevearc/oil)
      telescope.lua              -- fuzzy finder
      gitsigns.lua               -- inline git signs + hunk ops
      lualine.lua                -- statusline
      trouble.lua                -- diagnostics/symbols/refs panel
      indent.lua                 -- indent-blankline
      render_markdown.lua        -- inline markdown rendering
      go.lua                     -- go.nvim augmentation (struct/tag/interface helpers)
      godoc.lua                  -- godoc.nvim (go doc viewer)
      diffview.lua               -- git diff/history viewer
      tmux_navigator.lua         -- vim-tmux-navigator integration
      which_key.lua              -- prefix discovery (loaded near last)
      colorscheme.lua            -- vscode.nvim (LAST: highlight overrides win)
  lsp/                           -- per-server LSP config (Neovim 0.11+ native)
    lua_ls.lua
    ts_ls.lua
    yamlls.lua
    gopls.lua
    svelte.lua
  after/
    ftplugin/
      go.lua                     -- buffer-local Go keymaps (go.nvim + godoc.nvim)
  nvim-pack-lock.json            -- pinned plugin commits (commit this)
  .stylua.toml                   -- formatter config
```

`init.lua` ordering matters: `options` first (sets `mapleader` before any
plugin loads), then `keymaps`, then `diagnostics`, then `plugins` (which
loads everything in dependency order), then `autocmds`, `terminal`, `clean`.

---

## 3. Leader-prefix keymaps

Press the leader (`Space`) then wait — which-key shows the group and options.

### `<leader>b` — Buffer

| Key | Action |
| --- | --- |
| `bd` | Delete current buffer |
| `bn` | New empty buffer |

(Buffer navigation: `]b` / `[b`.)

### `<leader>c` — Code

| Key | Action |
| --- | --- |
| `ca` | LSP code action (normal + visual) |

In Go buffers, `after/ftplugin/go.lua` adds these buffer-local bindings (also surfaced by which-key under the `cf` / `ci` / `ct` groups):

| Key | Action |
| --- | --- |
| `cie` | Insert `if err != nil` block (`GoIfErr`) |
| `cfs` | Fill struct (`GoFillStruct`) |
| `cfw` | Fill switch (`GoFillSwitch`) |
| `cii` | Implement interface (`GoImpl`) |
| `cta` | Add struct tag (`GoAddTag`) |
| `ctr` | Remove struct tag (`GoRmTag`) |
| `ctm` | Modify struct tag (`GoModifyTag`) |
| `cic` | Insert godoc comment (`GoCmt`) |
| `cga` | Go to alternate file (`GoAlt`) |
| `cd`  | Go doc viewer (`GoDoc`) |

### `<leader>e` — Explorer

| Key | Action |
| --- | --- |
| `e` | Open Oil at current file's directory |

### `<leader>f` — Format

`<leader>f` (n + v) — async `conform.format` on the buffer (or selection),
falling back to LSP if no formatter is configured.

### `<leader>P` — Packages

`<leader>P` — prompt-then-delete unused packed plugins (also `:PackClean`).

### `<leader>g` — Git

| Key | Action |
| --- | --- |
| `gf` | Telescope `git_files` |
| `gd` / `gD` | Open / close Diffview |
| `gh` | Diffview file history (repo) |
| `gH` | Diffview file history (current file) |

### `<leader>h` — Hunk (gitsigns, buffer-local on attach)

| Key | Mode | Action |
| --- | --- | --- |
| `hs` | n / v | Stage hunk (or selection) |
| `hr` | n / v | Reset hunk (or selection) |
| `hp` | n | Preview hunk |
| `hb` | n | Blame current line (full popup) |
| `hd` | n | Diff buffer vs index in a split |

(Hunk navigation: `]h` / `[h`. Toggle the always-on inline blame with `<leader>tb`.)

### `<leader>q` — Diagnostic loclist

`<leader>q` — populate location list with workspace diagnostics.

### `<leader>r` — Rename (LSP)

`<leader>rn` — LSP rename symbol under cursor.

### `<leader>s` — Search (Telescope)

| Key | Action |
| --- | --- |
| `sh` | Help tags |
| `sm` | Man pages |
| `sk` | Keymaps |
| `sf` | Find files |
| `ss` | Built-in pickers list |
| `sw` | Grep current word (n + v) |
| `sg` | Live grep |
| `sd` | Diagnostics |
| `sr` | Resume last picker |
| `s.` | Recent files |
| `sc` | Commands |
| `s/` | Live grep in open buffers |
| `sn` | Find files in `~/.config/nvim` |
| `<leader><leader>` | Buffer picker |

### `<leader>t` — Toggle

| Key | Action |
| --- | --- |
| `tt` | Toggle floating terminal |
| `th` | Toggle LSP inlay hints (auto-on at attach) |
| `tv` | Toggle expanded virtual-lines diagnostics (current line only) ↔ compact virtual-text |
| `tm` | Toggle markdown rendering |
| `tb` | Toggle gitsigns inline blame |
| `td` | Dismiss Noice notifications |

### `<leader>u` — Undo tree

`<leader>u` — toggle Undotree window.

### `<leader>w` — Window

| Key | Action |
| --- | --- |
| `wv` | Vertical split |
| `ws` | Horizontal split |
| `wc` | Close window |
| `wo` | Only (close other windows) |
| `w=` | Equal sizes |

### `<leader>x` — Trouble

| Key | Action |
| --- | --- |
| `xx` | Workspace diagnostics |
| `xX` | Buffer diagnostics |
| `xs` | Symbols panel (right side) |
| `xl` | Location list |
| `xq` | Quickfix list |
| `xr` | LSP references / definitions |

### `<leader>y` / `<leader>p` — System clipboard

`<leader>y` yank to `+`, `<leader>p` paste from `+`, both in n+v.
`<leader>P` (visual, capital P) — paste without clobbering the register.

---

## 4. Non-leader keymaps

### Window navigation

`<C-h>` `<C-j>` `<C-k>` `<C-l>` — switch window left/down/up/right.
With `christoomey/vim-tmux-navigator` and the matching tmux config, these
also cross over into tmux panes seamlessly. `C-\` jumps to the previous
tmux pane.

### Window resize

`<C-Up>` `<C-Down>` — height ±2. `<C-Left>` `<C-Right>` — width ±2.

### Search centering

`n` / `N` — next / prev match, centered with `zz` and unfolded with `zv`.
`<C-d>` / `<C-u>` — half-page scroll, centered.

### Visual mode

| Key | Action |
| --- | --- |
| `<` / `>` | Indent left/right and re-select |
| `J` / `K` | Move selection down / up |
| `<leader>P` | Paste over selection without clobbering register |

### Quickfix and buffer brackets

| Key | Action |
| --- | --- |
| `]q` / `[q` | Next / prev quickfix (centered) |
| `]Q` / `[Q` | Last / first quickfix |
| `]b` / `[b` | Next / prev buffer |
| `]d` / `[d` | Next / prev diagnostic (with float) |
| `]h` / `[h` | Next / prev gitsigns hunk |

### Treesitter textobjects (select)

In operator-pending or visual mode:

| Key | Object |
| --- | --- |
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `aa` / `ia` | Outer / inner parameter |

Examples: `daf` delete a function, `vif` select function body, `cic`
change inside class.

### Treesitter motion (jumps; sets jump list)

| Key | Action |
| --- | --- |
| `]f` / `[f` | Next / prev function start |
| `]F` / `[F` | Next / prev function end |
| `]c` / `[c` | Next / prev class start |
| `[x` | Jump to parent scope (treesitter-context) |

### nvim-surround (no leader)

| Key | Action |
| --- | --- |
| `ys{motion}{c}` | Add surround `c` around motion (e.g. `ysiw"` adds quotes around word) |
| `yss{c}` | Surround whole line |
| `cs{old}{new}` | Change surround (e.g. `cs"'` → swap `"` for `'`) |
| `ds{c}` | Delete surround |
| `S{c}` (visual) | Surround the selection |

### Floating terminal

`<leader>tt` or `:Floaterminal` — toggle a centered floating terminal.
Inside the terminal, `<Esc><Esc>` exits terminal mode (use normal nvim
motions to scroll, then `i` to re-enter terminal mode).

---

## 5. LSP keymaps (active when an LSP attaches)

Set by the `LspAttach` autocmd in `lua/plugins/lsp.lua`. All buffer-local.

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `gy` | Type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action (n + x) |
| `<leader>th` | Toggle inlay hints (already auto-enabled on attach) |
| `K` (default Neovim) | Hover doc |
| `<C-]>` (default) | Tag-like jump → definition |

The LspAttach handler also enables document highlighting: on `CursorHold`
matching references are highlighted; on `CursorMoved` they clear.

---

## 6. Diagnostics

Config lives in `lua/diagnostics.lua`.

- Virtual text by default (`●` prefix).
- Underline only on `WARN` or worse.
- `update_in_insert = false` — diagnostics refresh on leave-insert.
- Float on jump: bordered, source shown if multiple.
- Severity-sorted in the list.

Keys: `]d` / `[d` to jump, `<leader>q` to loclist,
`<leader>tv` to toggle the expanded virtual-lines view for the current
line.

Trouble alternative: `<leader>xx` (workspace) and `<leader>xX` (buffer)
open a structured panel.

---

## 7. Completion (blink.cmp)

Sources (priority order): `lsp`, `path`, `snippets`, `buffer`.

- LSP falls back to buffer when no completions.
- Buffer source only fires after 3 chars; capped at 5 items.
- Auto brackets enabled on accept (functions get `(` `)`).
- Documentation auto-shows after 200ms.
- Path source resolves real devicons for files and folder glyph for dirs.
- Rust fuzzy backend preferred.

Default blink keymaps (consult `:help blink-cmp`): `<C-y>` accept,
`<C-n>` / `<C-p>` next / prev, `<C-Space>` open menu.

---

## 8. Plugin-specific quick refs

### Oil (file explorer)

`<leader>e` opens the parent directory of the current file as a buffer.
Edit it like any text buffer — add/remove/rename lines — then `:w` to
apply filesystem changes. `-` goes up a directory, `<CR>` opens, `<C-s>`
opens in vertical split, `g?` shows help. LSP rename is autosaved when
you rename a file in Oil.

### Telescope

Inside a picker:
- `<C-n>` / `<C-p>` cycle
- `<C-q>` send to quickfix
- `<C-x>` / `<C-v>` open in horizontal / vertical split
- `<C-t>` open in new tab
- `<C-/>` show mappings

The `<leader>s/` picker greps only across open buffers.

### Gitsigns

Inline `+` `~` `_` signs. `current_line_blame` is on (shows author /
relative time / summary virtual-text on the current line). Use the
hunk keymaps for stage / reset / preview; jump with `]h` / `[h`.

### Diffview

`:DiffviewOpen` (or `<leader>gd`) opens a side-by-side view of all
modified files vs the index. `:DiffviewFileHistory` shows commit history.
Navigate the file panel with `j`/`k`, `<CR>` to focus, `q` to close.

### Undotree

`<leader>u` opens the tree visualization. `j`/`k` walk versions,
`<CR>` jumps to that state, `?` shows help.

### Surround / Autopairs

Autopairs auto-closes brackets/quotes as you type and is
treesitter-aware (no extra `"` inside a Lua string). Use `<M-e>` for
fast-wrap (wrap an existing word with a pair).

Surround is purely manual: `ys` add, `cs` change, `ds` delete.

### Render-markdown

Renders headings, code blocks, lists, and inline code in the buffer
itself. Toggle with `<leader>tm`. Disabled by default for
indent-blankline (set in `indent.lua` exclude list).

### Trouble

Inside a Trouble panel: `<CR>` jump, `<C-x>` / `<C-v>` open in split,
`o` jump + close, `q` close, `r` refresh, `R` toggle auto-refresh,
`P` toggle preview, `?` help.

---

## 9. Workflows

### Find and edit a file

1. `<leader>sf` — pick by filename
2. or `<leader>sg` — pick by content (live grep)
3. or `<leader><leader>` — pick from open buffers
4. or `<leader>e` — browse with Oil

### Navigate code

1. `gd` to jump to definition.
2. `<C-o>` to jump back; `<C-i>` to jump forward.
3. `gr` for references (or `<leader>xr` for the Trouble panel).
4. `]f` / `[f` to jump function-by-function inside a file.
5. `gO` (document symbols) or `gW` (workspace symbols) for big picture.

### Refactor a name

1. Cursor on the symbol.
2. `<leader>rn` — LSP rename. Type the new name. `<CR>` to apply.

### Stage a change

1. `]h` / `[h` to walk hunks.
2. `<leader>hp` to preview a hunk.
3. `<leader>hs` (n) for whole hunk, or visual-select + `<leader>hs` for
   partial.
4. `<leader>hr` to reset a hunk.

### Review a branch diff

1. `<leader>gd` — opens diffview of working tree vs index.
2. `:DiffviewOpen main...HEAD` for branch diff.
3. `<leader>gh` for repo history; `<leader>gH` for current file history.

### Edit around scopes (treesitter)

- `vif` then `=` — select inner function and re-indent.
- `daf` — delete the whole function.
- `cic` — change inside class.
- `]f` then `vaf` — jump to next function, select it.
- `[x` — jump back up the scope stack (sticky context).

### Surround / change quotes

- `cs"'` — change double to single quotes around cursor.
- `ds(` — remove surrounding parens.
- `ysiw)` — surround word with parens (no inner spaces).
- `S"` in visual mode — wrap the selection with double quotes.

### Search and replace in a file

1. `/pattern` — `inccommand=split` previews changes in a side split.
2. `:%s/old/new/g` — confirm with `c` flag for prompted replace.

### Quickfix workflow

1. `<leader>sg` find matches.
2. `<C-q>` send Telescope results to quickfix.
3. `]q` / `[q` walk.
4. `:cdo s/old/new/g | update` — apply edits across the list.

---

## 10. Maintenance

### Update plugins

`:lua vim.pack.update()` — fetches and updates plugins, writes
`nvim-pack-lock.json`. Commit the lock file after updates.

### Pin a plugin

In `lua/plugins/init.lua`, add `version = "v1.2.3"` (tag) or a commit SHA
to the `{src = ...}` entry.

### Remove a plugin

1. Delete the `{ src = ... }` line in `lua/plugins/init.lua`.
2. Delete the matching `require("plugins.<name>")` line.
3. Delete the config file under `lua/plugins/<name>.lua`.
4. Restart nvim; the plugin is now inactive.
5. `<leader>cu` lists inactive plugins and offers to delete them on disk.

### Add a new LSP server

1. Add the mason binary name to `ensure_installed` in
   `lua/plugins/lsp.lua`.
2. Add the lspconfig server name to the `vim.lsp.enable({...})` list in
   the same file.
3. (Optional) Create `nvim/lsp/<server>.lua` returning a table of
   `settings`, `init_options`, `cmd`, etc. — automatically merged in.
4. Restart nvim. Mason installs the binary; `LspAttach` runs on next
   matching filetype.

### Add a new formatter

1. Add the binary to `ensure_installed` in `lua/plugins/lsp.lua` (it goes
   through mason-tool-installer regardless of category).
2. Map it to filetype(s) in `lua/plugins/formatting.lua` under
   `formatters_by_ft`. Multiple in an array run in order.

### Format manually (skip on-save)

`<leader>f` (n + v) or `:lua require("conform").format({ async = true, lsp_format = "fallback" })`.

### Disable format-on-save

`:FormatDisable` — globally; `:FormatDisable!` — current buffer only.
`:FormatEnable` — re-enable.

These flip `vim.g.disable_autoformat` / `vim.b.disable_autoformat`, which
the `format_on_save` callback in `lua/plugins/formatting.lua` checks before
running.

### Add a treesitter parser

In `lua/plugins/treesitter.lua` add the language name to the
`require("nvim-treesitter").install({ ... })` list. Restart nvim or run
`:lua require("nvim-treesitter").install({"<lang>"})`.

### Reload a single Lua module

`:lua package.loaded["module.path"] = nil; require("module.path")` — useful
after editing a `lua/plugins/*.lua` file without restarting.

### Check health

`:checkhealth` for everything, `:checkhealth lsp` / `mason` / `treesitter`
to scope.

---

## 11. Tmux integration

With `vim-tmux-navigator` (nvim plugin) plus the matching tmux config:

- `<C-h>` `<C-j>` `<C-k>` `<C-l>` cross seamlessly between nvim splits
  and tmux panes.
- `C-\` jumps to the previous tmux pane (or buffer in nvim if applicable).
- Tmux side reload: `prefix r` re-sources `tmux.conf`.

---

## 12. Cheatsheet table of contents

If which-key is on (it is) and you forget a binding, just press the
prefix and pause. The popup lists every key in that group with its
description.

- `<leader>` → see all top-level groups
- `g` → standard Vim `g`-commands plus LSP `gd`, `gr`, `gO`, `gW`, etc.
- `]` / `[` → all next/prev bracket motions (quickfix, diagnostic, hunk,
  buffer, function, class)

To search keymaps by description text: `<leader>sk`.
