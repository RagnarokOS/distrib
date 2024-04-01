#!/bin/sh

# Customize script
# $Ragnarok: customize01.sh,v 1.5 2024/04/01 17:31:20 lecorbeau Exp $

set -e

# Install dummy man-db package
mkdir -p "$1"/usr/src/ragnarok
cp live/cli/config/packages.chroot/man-db_999+ragnarok01_amd64.deb "$1"/usr/src/ragnarok/
chroot "$1" for _pkg in /usr/src/ragnarok/*.deb; do dpkg -i "$_pkg"; done
rm -r "$1"/usr/src/ragnarok

# Enable the wheel group
sed -i '15 s/^# //' "$1"/etc/pam.d/su
chroot "$1" addgroup --system wheel

# Set the default DEBIAN_FRONTEND to 'Readline'
chroot "$1" echo 'debconf debconf/frontend select Readline' | debconf-set-selections
