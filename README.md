# dotfiles

## Setup

Homebrew must be installed first. Everything else is `./install`:

```sh
./install          # install the Brewfile, link any config that isn't linked yet
./install --force  # same, but replace whatever is sitting in a symlink's place
./install --check  # change nothing, just report drift (non-zero exit if any)
```

## What it manages

| Repo               | Home                   |
| ------------------ | ---------------------- |
| `zsh/.zshrc`       | `~/.zshrc`             |
| `git/config`       | `~/.config/git/config` |
| `git/ignore`       | `~/.config/git/ignore` |
| `tmux`             | `~/.config/tmux`       |
| `nvim`             | `~/.config/nvim`       |
| `ssh/config`       | `~/.ssh/config`        |
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md`  |


## Overrides

Untracked and optional:

- `~/.ssh/local.config` — extra hosts
- `~/.config/git/local.config` — overrides
