# load colors
autoload -U colors && colors

if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls -hF --color=auto'
    export GREP_OPTIONS='--color=auto'
    export LESS='-R'
fi
