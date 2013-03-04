# auto cd when command doesn't exist and is a directory name
setopt autocd

# push the old dir onto the dir stack and ignore duplicates
setopt auto_pushd
setopt pushd_ignore_dups

# rationalise-dot
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
