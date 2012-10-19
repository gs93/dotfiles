# TODO: needs cleanup

# vars {{{
EDITOR='vim'
BROWSER='firefox'

GIT_PROMPT_UNTRACKED='untracked '
GIT_PROMPT_ADDED='added '
GIT_PROMPT_MODIFIED='modified '
GIT_PROMPT_RENAMED='renamed '
GIT_PROMPT_DELETED='deleted '
GIT_PROMPT_UNMERGED='unmerged '
# }}}

# alias {{{1
setalias() {
    # functions {{{2
    cdd() {
        cd "${1}" && ls --color=auto ;
    }

    rmrecent() {
        shred -un 3 $HOME/.local/share/recently-used.xbel ;
        touch ~/.local/share/recently-used.xbel ;
        echo "Filehistory delted." ;
    }

    cpl() {
        # TODO: if number use PID (-p), if text use program (-e), if slash use path (-P)
        sudo cpulimit -l $1 -p $2 -z;
    }

    ssh() {
        kf="$HOME/.ssh/keys/$1"
        [[ -f "$kf" ]] && eval $(keychain --eval --agents ssh -Q --quiet "$kf")
        # /usr/bin as workaround for: alias_ssh:3: maximum nested function level reached
        /usr/bin/ssh "$1"
    }

    scp() {
        kf="$HOME/.ssh/keys/$1"
        [[ -f "$kf" ]] && eval $(keychain --eval --agents ssh -Q --quiet "$kf")
        scp "$1"
    }
    # 2}}}
    # filesystem {{{2
    alias lsg='ls --color=auto | grep -i'
    alias -- -al='ls -al'
    alias cd.='cd ..'
    alias ..='cd ..'
    alias cpr='rsync -av --progress'
    alias ndu='ncdu -r'
    alias smart='sudo smartctl -H'
    # 2}}}
    # process management {{{2
    alias psg='ps aux | grep'
    alias kll='kill -KILL'
    alias klla='killall -KILL'
    # 2}}}
    # random stuff {{{2
    alias cputemp='cat /proc/acpi/thermal_zone/THRM/temperature'
    alias man='man'
    alias bman='man -H/home/gl/Documents/scripts/man.sh'
    alias xgetrules='xprop | grep -ie "^wm_class" -e "^wm_name"'
    alias xdebug='Xephyr :1 -ac -br -noreset -screen 1152x720 &'
    #alias shutdown='sudo shutdown -h now'
    alias shutdown='commands.sh shutdown'
    alias reboot='sudo reboot'
    alias whenn='when y | head -7 | tail -5'
    alias youtube-mp3='youtube-dl --title --extract-audio --audio-format mp3'
    alias dmsg='watch -n 1 dmesg -Tx \| tail -n'
    alias cppcheck='cppcheck --enable=all --platform=unix64 --report-progress --std=c++11'
    alias nb='newsbeuter'
    alias top15='print -l ? ${(o)history%% *} | uniq -c | sort -nr | head -n 15'
    #alias screen-add='xrandr --output VGA1 --mode 1280x1024 --right-of LVDS1 && nitrogen --restore'
    alias screen-add='$HOME/.screenlayout/home.sh && sleep 3s && nitrogen --restore'
    alias screen-remove='xrandr --output VGA2 --off'
    alias zshsource="source $HOME/.zshrc"
    # 2}}}
    # short {{{2
    alias s='sudo'
    alias l='ls'
    alias v='vim'
    alias t='top -d 3' # refresh every -d seconds
    # 2}}}
    # cryptsetup {{{2
    alias cryptsetup-mount='~scripts/cryptsetup-mount.sh'
    alias cryptsetup-umount='~scripts/cryptsetup-umount.sh'
    alias luksOpen='sudo cryptsetup luksOpen'
    alias luksClose='sudo cryptsetup luksClose'
    # 2}}}
    # backups {{{2
    rsnap() {
        if [ ! $1 ]; then
            echo "fail :P"
            exit 1;
        fi
        date
        (sudo rsnapshot sync && sudo rsnapshot $1)
        if [ $? -eq 0 ]; then
            echo "Sucess!"
        else
            echo "Fail!"
            exit 1;
        fi
    }
    # 2}}}
    # pkg management {{{2
    local refreshWidget='killall -USR2 dwmstatus'
    local refreshZshCache='~scripts/zsh-cache.sh'
    alias pacup="sudo pacman -Su && $refreshZshCache ; $refreshWidget"
    alias pacdl='sudo pacman -Suw --noconfirm'
    alias pacref="( ~scripts/sah.pl & ) ; sudo pacman -Sy ; cat $HOME/.cache/sah ; $refreshWidget"
    alias pacin='sudo pacman -S'
    alias pacrm='sudo pacman -Rns'
    alias pacrem='sudo pacman -R' # keep deps
    alias pacown='pacman -Qo'
    alias paclist='pacman -Ql'
    alias paclocs='pacman -Qs'
    alias pacloc='pacman -Qi'
    alias pacreps='pacsearch' #'pacman -Ss'
    alias pacrep='pacman -Si'
    alias aurreps='yaourt -Ss'
    alias aurrep='yaourt -Si'
    alias aurinst='yaourt -S'
    alias aurupg='yaourt -Sau'
    alias pacopt='paccache -vr && sudo pacman-optimize; du -hs /var/cache/pacman/ /var/abs/'
    alias pacunused="pacman -Qdtq | sudo pacman -Rs -"
    # 2}}}
    # global {{{2
    alias -g G='| grep'
    alias -g L='| less'
    alias -g T='| tail -n'
    alias -g H='| head -n'
    # 2}}}
    # suffix {{{2
    alias -s txt=$EDITOR
    #alias -s php=$EDITOR
    alias -s cpp=$EDITOR
    alias -s hpp=$EDITOR
    alias -s conf=$EDITOR
    # 2}}}
    # hashes {{{2
    hash -d projects=$HOME/documents/projects
    hash -d scripts=$HOME/documents/scripts
    hash -d data=/media/data
    hash -d data2=/media/data2
    hash -d study=$HOME/documents/box/study
    # 2}}}
}
# 1}}}

# general config (colors, promt, ..) {{{
function prompt_char { # http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/#repository-types
    hg status >/dev/null 2>/dev/null && echo '☿' && return
    git status >/dev/null 2>/dev/null && echo '±' && return
    echo '$'
}

setpromptcolor () {
    setopt prompt_subst
    setopt correct
    
    ###
    # See if we can use colors.
 
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
            colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
            eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
            eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
            (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"
 
 
    ###
    # See if we can use extended characters to look nicer.
 
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}
 
    if [[ "$TERM" == "screen" ]]; then
        PR_HBAR=-
        PR_ULCORNER=--
        PR_LLCORNER=--
    	PR_LRCORNER=--
    	PR_URCORNER=-
    fi 
 
 
    ###
    # Decide if we need to set titlebar text.
 
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
 
 
    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
        PR_STITLE=$'%{\ekzsh\e\\%}'
    else
        PR_STITLE=''
    fi

    autoload colors zsh/terminfo
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ \a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ \e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    
    PS1='abc'
    export PS1
    
    #PROMPT='$PR_STITLE${(e)PR_TITLEBAR}%m:%~%<<$ '
    PROMPT='$PR_STITLE${(e)PR_TITLEBAR}%m:%~%<<$(prompt_char) '
    RPROMPT='%D{%H:%M:%S}'
} # }}}

# promt settings {{{
setpromtsettings() {
    HISTSIZE=15000
    SAVEHIST=15000
    HISTFILE=$HOME/.cache/zsh/history
    setopt APPEND_HISTORY
} # }}}

# keybindings {{{
setkeybindings() {
    # for linux console and RH/Debian xterm
    bindkey "\e[1~" beginning-of-line
    bindkey "\e[4~" end-of-line
    bindkey "\e[5~" beginning-of-history
    bindkey "\e[6~" end-of-history
    bindkey "\e[7~" beginning-of-line
    bindkey "\e[3~" delete-char
    bindkey "\e[2~" quoted-insert
    bindkey "\e[5C" forward-word
    bindkey "\e[5D" backward-word
    bindkey "\e\e[C" forward-word
    bindkey "\e\e[D" backward-word
    bindkey "\e[1;5C" forward-word
    bindkey "\e[1;5D" backward-word

    # for rxvt
    bindkey "\e[8~" end-of-line

    # for non RH/Debian xterm, can't hurt for RH/DEbian xterm
    bindkey "\eOH" beginning-of-line
    bindkey "\eOF" end-of-line

    # for freebsd console
    bindkey "\e[H" beginning-of-line
    bindkey "\e[F" end-of-line
} # }}}

# windowtitle {{{
settitle() {
    if [[ $TERM == "screen" ]]; then
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
# }}}

# autocomplete {{{
setcomplete() { #  see man zshcompctl
    autoload -U compinit
    compinit

    setopt completealiases

    for i in $HOME/.cache/zsh/complete/*; do
        compctl -k "(`cat $i`)" $(basename "$i")
    done
} # }}}

# rationalise-dot {{{
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# }}}

# some other stuff {{{
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls -hF --color=auto'
fi

[[ $TERM != "screen" ]] && tmux attach && exit

# ccache
export PATH="/usr/lib/ccache/bin/:$PATH"
export CCACHE_DIR="$HOME/.cache/ccache"

# stty (else ^S freeze terminal until ^Q)
stty start undef
stty stop undef

# options
setopt correct
setopt auto_pushd
# }}}

# execute functions {{{
setcomplete
setpromptcolor
setpromtsettings
setkeybindings
setalias
# }}}
# vim:foldmethod=marker
