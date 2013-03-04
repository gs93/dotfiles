settitle() {
    if [[ $TERM == "screen" || $TERM == "screen-256color" ]]; then
        #PR_STITLE=$'%{\ek'$1$'\e\\%}'
        local title; title=$1
        if [ ${#title} -gt 12 ]; then
            title="${title:0:10}.."
        fi
        # http://superuser.com/a/249322
        printf "\033k$title\033\\"
    fi
}

preexec() {
    emulate -L zsh
    local -a cmd; cmd=(${(z)1})
    local title; title="$cmd[1]"
    local prgs; prgs=(vim v ssh scp man sudo s  mplayer zathura info)
    local rpls; rpls=(v   v s   scp m   ''   '' mpl     z       i)
    local i; i=0
    for p in $prgs; do
        (( i++ ))
        if [ "$title" = "$p" ]; then
            local param; param=$(basename $cmd[2] 2>/dev/null)
            title="$rpls[$i]~$param"
            break;
        fi
    done
    settitle "$title"
}
