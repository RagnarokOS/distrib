#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

WM="dwm"

xwallpaper --stretch ~/Pictures/defwall.jpg &
xcompmgr &
dunst &
sxhkd &

case "$WM" in
	cwm)	/usr/local/bin/cwmbar &
		exec /usr/bin/cwm
		;;
	dwm)	/usr/local/bin/statusbar.sh &
		exec /usr/local/bin/dwm
esac

