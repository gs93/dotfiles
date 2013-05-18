source ${XDG_CONFIG_HOME:-~/.config}/zsh/init.zsh
loadPlugin tmux-autostart
loadPlugin packagemanagement
loadPlugin windowtitle
loadPlugin command-not-found
loadPlugin prompt-git
loadPlugin prompt-char
loadPlugin prompt-return
loadPlugin videolength
loadPlugin tetris

# alias {{{1
# functions {{{2
c() {
    cd "${1}" && ls
}
compdef c='cd'

rmrecent() {
    shred -un 3 $HOME/.local/share/recently-used.xbel
    truncate --size=0 $HOME/.local/share/recently-used.xbel
}

cpl() {
    # TODO: if number use PID (-p), if text use program (-e), if slash use path (-P)
    sudo cpulimit -l $1 -p $2 -z;
}
# 2}}}

# hashes {{{2
hash -d projects=$HOME/documents/projects
hash -d scripts=$HOME/documents/scripts
hash -d study=$HOME/documents/box/study
# 2}}}

# filesystem {{{2
alias lsg='ls --color=auto | grep -i'
alias la='ls -al'
alias -- -='cd -'
alias cpr='rsync -av --progress'
alias ndu='ncdu -r'
alias smart='sudo smartctl -H'
# 2}}}

# process management {{{2
alias psg='pgrep -a'
alias kll='kill -KILL'
alias klla='killall -KILL'
# 2}}}

# random stuff {{{2
alias xgetrules='xprop | grep -ie "^wm_class" -e "^wm_name"'
alias xdebug='Xephyr :1 -ac -br -noreset -screen 1152x720 &'
alias shutdown='commands.sh shutdown'
alias whenn='when w --noheader'
alias youtube-mp3='youtube-dl --title --extract-audio --audio-format mp3'
alias dmsg='watch -n 1 dmesg -Tx \| tail -n'
alias cppcheck='cppcheck --enable=all --platform=unix64 --report-progress --std=c++11'
alias screen-add='$HOME/.screenlayout/home.sh && sleep 3s && nitrogen --restore'
alias screen-remove='xrandr --output VGA2 --off'
alias zshsource="source $HOME/.zshrc"
# 2}}}

# short {{{2
alias s='sudo'
compdef s='sudo'
alias l='ls'
alias v='vim'
alias t='top -d 3' # refresh every -d seconds
alias x='exit'
# 2}}}

# cryptsetup {{{2
alias cryptsetup-mount='~scripts/cryptsetup-mount.sh'
alias cryptsetup-umount='~scripts/cryptsetup-umount.sh'
alias luksOpen='sudo cryptsetup luksOpen'
alias luksClose='sudo cryptsetup luksClose'
# 2}}}

# packagemanagement {{{2
local refreshWidget='killall -USR2 dwmstatus 2>/dev/null'
local refreshZshCache='~scripts/zsh-cache.sh'
local aurUpdate='~scripts/sah.pl'
alias pacup="sudo pacman -Su && $refreshZshCache ; $refreshWidget"
alias pacref="( $aurUpdate & ); sudo pacman -Sy ; $refreshWidget"
# 2}}}

# global {{{2
alias -g G='| grep'
alias -g L='| less'
alias -g T='| tail -n'
alias -g H='| head -n'
alias -g W='| wc'
alias -g LL='2>&1 | less'
alias -g CA='2>&1 | cat -A'
alias -g NO='>/dev/null'
alias -g NE='2>/dev/null'
alias -g SP=' |& curl -F sprunge=@- sprunge.us'
# 2}}}
# 1}}}
# vim:foldmethod=marker
