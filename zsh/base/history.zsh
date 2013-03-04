HISTSIZE=15000
SAVEHIST=15000
HISTFILE=$DATA_DIR/history
[[ ! -d $(dirname "$HISTFILE") ]] && mkdir -p $(dirname "$HISTFILE")

# append history and ignore duplicates
setopt append_history
setopt hist_ignore_all_dups
