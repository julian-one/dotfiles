# Dotfiles

Configuration files managed with [GNU Stow](https://www.gnu.org/software/stow).

## Packages

- `ghostty`
- `git`
- `hypr`
- `nvim`
- `waybar`
- `wofi`
- `zsh`

## Usage

```sh
# Link a package
stow -t ~ ghostty

# Link all packages
stow -t ~ */

# Unlink a package
stow -t ~ -D ghostty
```
