# load colors
autoload -U colors && colors

if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    export GREP_OPTIONS="$GREP_OPTIONS --color=auto"
    export LESS="$LESS -R"

    # ls doesn't support export
    export LS_OPTIONS="$LS_OPTIONS --color=auto"
    alias ls="ls $LS_OPTIONS"
fi
