# TODO: needs cleanup

# vars {{{
EDITOR='vim'
BROWSER='firefox'
# }}}

# alias {{{1
setalias() {
    # functions {{{2
    cdd() {
        cd "${1}" && ls ;
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
    alias xgetrules='xprop | grep -ie "^wm_class" -e "^wm_name"'
    alias xdebug='Xephyr :1 -ac -br -noreset -screen 1152x720 &'
    alias shutdown='commands.sh shutdown'
    alias whenn='when y | head -7 | tail -5'
    alias youtube-mp3='youtube-dl --title --extract-audio --audio-format mp3'
    alias dmsg='watch -n 1 dmesg -Tx \| tail -n'
    alias cppcheck='cppcheck --enable=all --platform=unix64 --report-progress --std=c++11'
    alias nb='newsbeuter'
    alias screen-add='$HOME/.screenlayout/home.sh && sleep 3s && nitrogen --restore'
    alias screen-remove='xrandr --output VGA2 --off'
    alias zshsource="source $HOME/.zshrc"
    # 2}}}
    # short {{{2
    alias s='sudo'
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
    alias pacref="( ~scripts/sah.pl & ) ; sudo pacman -Sy ; $refreshWidget"
    alias pacin='sudo pacman -S'
    alias pacrm='sudo pacman -Rns'
    alias pacrem='sudo pacman -R' # keep deps
    alias pacown='pacman -Qo'
    alias paclist='pacman -Ql'
    alias paclocs='pacman -Qs'
    alias pacloc='pacman -Qi'
    alias pacreps='pacsearch' #'pacman -Ss'
    alias pacrep='pacman -Si'
    alias pacopt='paccache -vr && sudo pacman-optimize; du -hs /var/cache/pacman/ /var/abs/'
    alias pacunused="pacman -Qdtq | sudo pacman -Rs -"
    # 2}}}
    # global {{{2
    alias -g G='| grep'
    alias -g L='| less'
    alias -g T='| tail -n'
    alias -g H='| head -n'
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

# general config (promt, history, complete, ..) {{{
sethistory() { # {{{2
    HISTSIZE=15000
    SAVEHIST=15000
    HISTFILE=$XDG_CACHE_HOME/zsh/history
    setopt append_history
} # 2}}}

setcomplete() { # {{{2
    # see man zshcompctl
    autoload -U compinit
    compinit

    setopt completealiases
    
    if [ -d "$XDG_CACHE_HOME/zsh/complete" ]; then
        for i in $XDG_CACHE_HOME/zsh/complete/*; do
            compctl -k "(`cat $i`)" $(basename "$i")
        done
    fi
} # 2}}}

# setpromt {{{2
function prompt_char { # http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/#repository-types
    hg status >/dev/null 2>/dev/null && echo '☿' && return
    git status >/dev/null 2>/dev/null && echo '±' && return
    echo '$'
}

function prompt_return { # make prompt red if return != 0
    [[ $? -ne 0 ]] && echo "%{$fg[red]%}"
}

setprompt() {
    # parameter expansion, command substitution and arithmetic expansion
    setopt prompt_subst

    # set screen title
    PR_STITLE=$'%{\ekzsh\e\\%}'

    # set titlebar text
    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ \e\\%}'
    
    # ???
    PS1='abc'
    export PS1
    
    # set prompt
    PROMPT='$(prompt_return)$PR_STITLE${(e)PR_TITLEBAR}%m:%~%<<$(prompt_char)%{$reset_color%} '
    RPROMPT='%? %*'
} # 2}}}

setoptions() {
    # correct mistyped commands
    setopt correct
    
    # push the old dir onto the dir stack
    setopt auto_pushd

    # load colors
    autoload -U colors && colors

    # rationalise-dot
    rationalise-dot() {
        if [[ $LBUFFER = *.. ]]; then
            LBUFFER+=/..
        else
            LBUFFER+=.
        fi
    }
    zle -N rationalise-dot
    bindkey . rationalise-dot
}
# }}}

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

    # search
    bindkey '^[[A' history-beginning-search-backward
    bindkey '^[[B' history-beginning-search-forward
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

# some other stuff {{{
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls -hF --color=auto'
fi

# autostart tmux
[[ -z "$TMUX" ]] && tmux attach && exit

# ccache
export PATH="/usr/lib/ccache/bin/:$PATH"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# stty (else ^S freeze terminal until ^Q)
stty start undef
stty stop undef
# }}}

# execute functions {{{
setcomplete
sethistory
setprompt
setoptions
setkeybindings
setalias
# }}}
# vim:foldmethod=marker
