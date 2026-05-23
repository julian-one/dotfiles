# gh CLI: switch active account based on working directory.
# After `gh auth login` for the work account, set GH_USER_WORK to that username.
GH_USER_PERSONAL="julian-one"
GH_USER_WORK="julian-westhillglobal"

_gh_auto_switch() {
  [[ -z "$GH_USER_WORK" ]] && return
  command -v gh >/dev/null || return
  local want
  case "$PWD/" in
    "$HOME"/whg/*) want="$GH_USER_WORK" ;;
    *)             want="$GH_USER_PERSONAL" ;;
  esac
  local hosts="${GH_CONFIG_DIR:-$HOME/.config/gh}/hosts.yml"
  local active
  active=$(awk '/^    user:/ {print $2; exit}' "$hosts" 2>/dev/null)
  [[ "$active" == "$want" ]] && return
  gh auth switch -h github.com -u "$want" >/dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _gh_auto_switch
_gh_auto_switch
