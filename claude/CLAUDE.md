# Hard Rules

## Git

Never commit or push. Prepare files; I commit.

## Comments

No comments unless load-bearing — a non-obvious constraint, a workaround for a specific bug or upstream quirk, or a decision that looks wrong and would get "fixed" without it.
Never narrate what the code does. Rename or restructure instead.
Delete non-load-bearing comments in code you touch.

## Dependencies

Homebrew only, from ~/dotfiles/Brewfile. No npm globals, no curl-pipe installers.
Add a tool: append to the Brewfile, then `brew bundle --file ~/dotfiles/Brewfile`.
Drop a tool rather than install it outside brew.
