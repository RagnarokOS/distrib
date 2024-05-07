#!/bin/ksh

# Commands to configure miniroot.
# $Ragnarok: customize01.sh,v 1.2 2024/04/21 15:38:56 lecorbeau Exp $

set -e

# Set the default debconf frontend to Readline
chroot "$1" echo 'debconf debconf/frontend select Readline' | debconf-set-selections

# Enable the wheel group.
sed -i '15 s/^# //' "$1"/etc/pam.d/su
chroot "$1" addgroup --system wheel

# Make sure ksh is the default shell for root.
sed -i 's/bash/ksh/g' "$1"/etc/passwd
