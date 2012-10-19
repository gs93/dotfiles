#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [ "$(tty)" = "/dev/tty1" ]; then
    clear
	startx -- -nolisten tcp vt01 >/home/gl/.cache/tmp/startx.log 2>&1
	logout
fi
