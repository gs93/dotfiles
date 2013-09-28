if [[ -s /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue
    ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
    ZSH_HIGHLIGHT_PATTERNS+=('chown -R *' 'fg=white,bold,bg=red')
    ZSH_HIGHLIGHT_PATTERNS+=('chmod -R *' 'fg=white,bold,bg=red')
fi

