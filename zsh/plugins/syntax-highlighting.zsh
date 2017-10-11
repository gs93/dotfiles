if [[ -s /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue

    local warnCol='fg=white,bold,bg=red'
    ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' $warnCol)
    ZSH_HIGHLIGHT_PATTERNS+=('chown -R *' $warnCol)
    ZSH_HIGHLIGHT_PATTERNS+=('chmod -R *' $warnCol)
    ZSH_HIGHLIGHT_PATTERNS+=('shutdown' $warnCol)
    ZSH_HIGHLIGHT_PATTERNS+=('reboot' $warnCol)
fi

