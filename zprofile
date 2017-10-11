#
# ~/.zprofile
#

#[[ -f ~/.zshrc ]] && . ~/.zshrc

source /etc/profile.d/freetype2.sh

if [ "$(tty)" = "/dev/tty1" ]; then
    clear
    startx -- -nolisten tcp
    logout
fi
