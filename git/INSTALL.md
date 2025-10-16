# Git Setup Instructions

## 1. Generate SSH Keys

**Personal key:**
```bash
ssh-keygen -t ed25519 -C "38872371+julian-one@users.noreply.github.com" -f ~/.ssh/id_ed25519_personal
```

**Work key:**
```bash
ssh-keygen -t ed25519 -C "julianroberts@westhillglobal.com" -f ~/.ssh/id_ed25519_work
```

## 2. Add Keys to SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_personal
ssh-add ~/.ssh/id_ed25519_work
```

## 3. Configure SSH for Work Repositories

Create or append to `~/.ssh/config`:

```bash
cat >> ~/.ssh/config << 'EOF'
Host github-westhill
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_work
EOF
```

## 4. Add Public Keys to GitHub

**Personal account:**
```bash
cat ~/.ssh/id_ed25519_personal.pub
```
- Go to https://github.com/settings/ssh/new
- Paste the public key
- Add a title (e.g., "Fedora Macbook")

**Work account:**
```bash
cat ~/.ssh/id_ed25519_work.pub
```
- Go to https://github.com/settings/ssh/new
- Paste the public key
- Add a title (e.g., "Fedora Macbook - Work")
- **Important:** Click "Configure SSO" next to the key
- Authorize it for the `westhillglobal` organization

## 5. Test Connections

```bash
ssh -T git@github.com
```

Should see: "Hi julian-one! You've successfully authenticated..."

## 6. Stow Git Config

```bash
stow -v git
```

This symlinks git config files to `~/.config/git/`

## 7. Update Remote URLs to SSH

For any existing repos using HTTPS:

```bash
git remote set-url origin git@github.com:julian-one/dotfiles.git
```

## How It Works

- Personal repos: Uses `~/.ssh/id_ed25519_personal` by default
- Work repos in `~/whg/`: Automatically uses work email and `~/.ssh/id_ed25519_work` via git config `includeIf`
- The `github-westhill` SSH host alias ensures work repos use the correct SSH key
