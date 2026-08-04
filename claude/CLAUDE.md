# Hard Rules

## Git

Never commit or push.

## Comments

No comments ever.

## Dependencies

- Homebrew ONLY, [review](~/dotfiles/Brewfile).
- Exception: nvim tooling (LSP servers, formatters, linters, Go helpers) is managed by Mason inside nvim, never brew.
- No npm globals, no curl-pipe installers.
- Add a CLI tool: append to the Brewfile, then `brew bundle --file ~/dotfiles/Brewfile`.
- Add nvim tooling: `ensure_installed` in nvim/lua/plugins/lsp.lua.
- Drop a tool rather than install it outside brew or Mason.
