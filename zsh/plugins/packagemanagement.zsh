if (( $+commands[pacman] )); then # it's arch linux
    alias pacup='sudo pacman -Su'
    alias pacdl='sudo pacman -Suw --noconfirm'
    alias pacref='sudo pacman -Sy'
    alias pacin='sudo pacman -S'
    alias pacrm='sudo pacman -Rns'
    alias pacrem='sudo pacman -R' # keep deps
    alias pacown='pacman -Qo'
    alias paclist='pacman -Ql'
    alias paclocs='pacman -Qs'
    alias pacloc='pacman -Qi'
    if (( $+commands[pacsearch] )); then
        alias pacreps='pacsearch'
    else
        alias pacreps='pacman -Ss'
    fi
    alias pacrep='pacman -Si'
    if (( $+commands[paccache] )); then
        alias pacopt='paccache -vr && sudo pacman-optimize; du -hs /var/cache/pacman/'
    fi
    alias pacunused='pacman -Qdtq | sudo pacman -Rs -'
elif (( $+commands[apt-get] )); then # it's debian
    alias apt-update='apt-get update'
    alias apt-upgrade='apt-get upgrade'
fi
