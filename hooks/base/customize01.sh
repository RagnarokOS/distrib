#!/bin/ksh

# Commands to configure miniroot.
# $Ragnarok: customize01.sh,v 1.3 2024/06/30 15:21:33 lecorbeau Exp $

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

# Create signify symlink
chroot "$1" ln -sf /usr/bin/signify-openbsd /usr/bin/signify

# Install man-db dummy
_mdb_dummy="man-db_999+ragnarok01_amd64.deb"
cp iso/live/config/packages.chroot/"$_mdb_dummy" "$1"/
chroot "$1" apt-get install ./"$_mdb_dummy" -y
chroot "$1" rm "$_mdb_dummy"
