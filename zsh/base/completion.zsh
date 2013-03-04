# see man zshcompctl
autoload -U compinit
compinit

setopt completealiases

if [ -d "$CACHE_DIR/complete" ]; then
    for i in $CACHE_DIR/complete/*; do
        compctl -k "(`cat $i`)" $(basename "$i")
    done
fi
