#!/bin/ksh

# Commands to configure miniroot.
# $Ragnarok: customize01.sh,v 1.2 2024/06/28 18:00:53 lecorbeau Exp $

set -e

# Set the default debconf frontend to Readline
echo 'debconf debconf/frontend select Readline' | chroot "$1" debconf-set-selections

# Enable the wheel group.
sed -i '15 s/^# //' "$1"/etc/pam.d/su
chroot "$1" addgroup --system wheel

# Make sure ksh is the default shell for root.
sed -i 's/bash/ksh/g' "$1"/etc/passwd

# Install ragnarok-base. 
chroot "$1" apt-get -o Apt::Install-Recommends="true" install ragnarok-base -y
