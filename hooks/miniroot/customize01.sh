#!/bin/sh

# $Ragnarok: customize01.sh,v 1.12 2024/01/31 19:54:56 lecorbeau Exp $

set -e

# Copy then install dummy packages
mkdir -p "$1"/usr/src/ragnarok
cp dummies/* "$1"/usr/src/ragnarok/
chroot "$1" dpkg -i /usr/src/ragnarok/ed_999+ragnarok01_amd64.deb

# Enable the wheel group
sed -i '15 s/^# //' "$1"/etc/pam.d/su
chroot "$1" addgroup --system wheel

# Making sure root's interactive shell is ksh
sed -i 's/bash/ksh/g' "$1"/etc/passwd
