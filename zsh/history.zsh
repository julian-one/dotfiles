HISTFILE=~/.zsh_history          # where to save history
HISTSIZE=10000                   # max entries in memory
SAVEHIST=10000                   # max entries in file
setopt append_history            # append instead of overwrite
setopt share_history             # share history across sessions
setopt hist_ignore_all_dups      # remove older duplicates from history
setopt hist_ignore_space         # ignore commands starting with space
setopt hist_expire_dups_first    # expire duplicates first when trimming
setopt hist_find_no_dups         # skip duplicates during search
setopt hist_verify               # show command before executing from history
