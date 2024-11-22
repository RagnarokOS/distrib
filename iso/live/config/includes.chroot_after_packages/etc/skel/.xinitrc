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

WM="raven"

hsetroot -add "#080808" -add "#484848" -gradient 170 -center /usr/share/X11/backgrounds/wallpaper0001.png &
xcompmgr &
dunst &
sxhkd &

case "$WM" in
	cwm)	killall -q polybar
		/usr/bin/polybar cwmbar &
		exec /usr/bin/cwm
		;;
	raven)	/usr/local/bin/statusbar.sh &
		exec /usr/bin/raven
		;;
esac

