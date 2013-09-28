if (( $+commands[fasd] )); then
    eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
    export _FASD_DATA="$HOME/.config/fasd"
    alias j='fasd_cd -d'
fi
