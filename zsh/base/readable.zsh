alias du='du -h'
alias df='df -h'
alias free='free -h'
alias rsync='rsync -h'

# ls doesn't support export
export LS_OPTIONS="$LS_OPTIONS -hF"
alias ls="ls $LS_OPTIONS"
