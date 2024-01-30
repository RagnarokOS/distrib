#!/bin/sh

# $Ragnarok: customize01.sh,v 1.11 2024/01/30 18:33:25 lecorbeau Exp $

set -e

# Set up the _sysupdate user. Needs to be done first.
chroot "$1" useradd --system --no-create-home --home /nonexistent --shell=/usr/sbin/nologin _sysupdate

# Copy then install dummy packages
mkdir -p "$1"/usr/src/ragnarok
cp dummies/* "$1"/usr/src/ragnarok/
chroot "$1" dpkg -i /usr/src/ragnarok/ed_999+ragnarok01_amd64.deb

# Enable the wheel group
sed -i '15 s/^# //' "$1"/etc/pam.d/su
chroot "$1" addgroup --system wheel

# Making sure root's interactive shell is ksh
sed -i 's/bash/ksh/g' "$1"/etc/passwd
