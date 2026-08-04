# dotfiles

## Setup

1. **Install dependencies:**

   ```sh
   brew bundle --file ~/dotfiles/Brewfile
   ```

2. **Symlink the configs:**

   ```sh
   mkdir -p ~/.config/git ~/.ssh
   chmod 700 ~/.ssh

   ln -sfn ~/dotfiles/zsh/.zshrc         ~/.zshrc
   ln -sfn ~/dotfiles/git/config         ~/.config/git/config
   ln -sfn ~/dotfiles/git/ignore         ~/.config/git/ignore
   ln -sfn ~/dotfiles/tmux               ~/.config/tmux
   ln -sfn ~/dotfiles/nvim               ~/.config/nvim
   ln -sfn ~/dotfiles/ssh/config         ~/.ssh/config
   ```

## Local

Untracked and optional:

- `~/.ssh/local.config` — extra hosts
- `~/.config/git/local.config` — overrides

## Verification

- `brew bundle check` — verify everything is installed
- `brew bundle cleanup` — list anything installed that the Brewfile doesn't own
