#	$OpenBSD: ksh.kshrc,v 1.32 2018/05/16 14:01:41 mpf Exp $
#
# NAME:
#	ksh.kshrc - global initialization for ksh
#
# DESCRIPTION:
#	Each invocation of /bin/ksh processes the file pointed
#	to by $ENV (usually $HOME/.kshrc).
#	This file is intended as a global .kshrc file for the
#	Korn shell.  A user's $HOME/.kshrc file simply requires
#	the line:
#		. /etc/ksh.kshrc
#	at or near the start to pick up the defaults in this
#	file which can then be overridden as desired.
#
# SEE ALSO:
#	$HOME/.kshrc
#

# RCSid:
#	$From: ksh.kshrc,v 1.4 1992/12/05 13:14:48 sjg Exp $
#
#	@(#)Copyright (c) 1991 Simon J. Gerraty
#
#	This file is provided in the hope that it will
#	be of use.  There is absolutely NO WARRANTY.
#	Permission to copy, redistribute or otherwise
#	use this file is hereby granted provided that
#	the above copyright notice and this notice are
#	left intact.

# Modified for Ragnarok by Ian LeCorbeau, 2022-10-22.

case "$-" in
*i*)	# we are interactive
	# we may have su'ed so reset these
	USER=$(id -un)
	UID=$(id -u)
	case $UID in
	0) PS1S='# ';;
	esac
	PS1S=${PS1S:-'$ '}

	# if escape sequences in the prompt messes up your
	# command line editor, use these instead to create
	# PS1. e.g. PS1='$USER@$HOSTNAME:$DIR$PS1S'
	#HOSTNAME=${HOSTNAME:-$(uname -n)}
	#HOST=${HOSTNAME%%.*}
	#DIR=$(/usr/bin/pwd | sed "s,^$HOME,~,g")

	PROMPT='\u@\h:\w$PS1S'
	PS1=$PROMPT

	alias ls='ls -F'
	alias h='fc -l | more'

	alias quit=exit
	alias cls=clear
	alias logout=exit
	alias bye=exit
	alias p='ps -l'
	alias df='df -k'
	alias du='du -k'
;;
*)	# non-interactive
;;
esac
