#!/bin/sh

# $Ragnarok: customize01.sh,v 1.2 2023/10/02 15:50:29 lecorbeau Exp $

set -e

# Copy then install dummy packages
mkdir -p "$1"/usr/src/ragnarok
cp dummies/* "$1"/usr/src/ragnarok/
for _file in base-files.conffiles base-files.list base-files.md5sums base-files.postinst; do
	rm "$1"/var/lib/dpkg/info/"$_file"
done
chroot "$1" dpkg -i /usr/src/ragnarok/base-files_99+ragnarok01_amd64.deb
chroot "$1" dpkg -i /usr/src/ragnarok/ed_99+ragnarok01_amd64.deb
chroot "$1" dpkg -i /usr/src/ragnarok/man-db_99+ragnarok01_amd64.deb

# Enable the wheel group
sed -i '15 s/^# //' "$1"/etc/pam.d/su
chroot "$1" addgroup --system wheel

# Making sure root's interactive shell is ksh
sed -i 's/bash/ksh/g' "$1"/etc/passwd

# Set the default DEBIAN_FRONTEND to 'Readline'
chroot "$1" echo 'debconf debconf/frontend select Readline' | debconf-set-selections

# Set up the _sysupdate user
chroot "$1" useradd --system --no-create-home --home /nonexistent --shell=/usr/sbin/nologin _sysupdate
chroot "$1" chown _sysupdate:_sysupdate /var/db/updates/sysupdate.list


# Needed to make the rootfs reproducible
rm "$1"/etc/resolv.conf
rm "$1"/etc/hostname
