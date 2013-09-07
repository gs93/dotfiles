#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

# fonts
xset +fp /usr/share/fonts/local
xset fp rehash

xsetroot -cursor_name left_ptr
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl
xrdb $HOME/.config/Xresources
xmodmap $HOME/.config/Xmodmap

wmname LG3D # workaround for java guis

commands.sh autostart

# so qt apps have gtk+ style
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

#exec openbox-session
#exec awesome
#exec dwm
#exec startdwm
exec i3
# ...or the Window Manager of your choice
#exec xterm
