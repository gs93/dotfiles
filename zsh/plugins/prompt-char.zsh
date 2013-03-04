function prompt_char { # http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/#repository-types
    #hg status >/dev/null 2>/dev/null && echo '☿' && return
    git status >/dev/null 2>/dev/null && echo '±' && return
    echo '$'
}
