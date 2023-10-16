#!/bin/sh

# Customize script
# $Ragnarok: customize01.sh,v 1.1 2023/10/16 15:54:11 lecorbeau Exp $

set -e

# Set up the _sysupdate user. Needs to be done first.
chroot "$1" useradd --system --no-create-home --home /nonexistent --shell=/usr/sbin/nologin _sysupdate

# Build src
make -C ../src DESTDIR="$1" miniroot

# Copy then install dummy packages
mkdir -p "$1"/usr/src/ragnarok
cp dummies/* "$1"/usr/src/ragnarok/
for _file in base-files.conffiles base-files.list base-files.md5sums base-files.postinst; do
	rm "$1"/var/lib/dpkg/info/"$_file"
done
chroot "$1" dpkg -i /usr/src/ragnarok/base-files_99+ragnarok01_amd64.deb
chroot "$1" dpkg -i /usr/src/ragnarok/ed_99+ragnarok01_amd64.deb

# Enable the wheel group
sed -i '15 s/^# //' "$1"/etc/pam.d/su
chroot "$1" addgroup --system wheel

# Add ksh to /etc/shells
chroot "$1" add-shell /bin/ksh

# Making sure root's interactive shell is ksh
sed -i 's/bash/ksh/g' "$1"/etc/passwd

# Set the default DEBIAN_FRONTEND to 'Readline'
chroot "$1" echo 'debconf debconf/frontend select Readline' | debconf-set-selections

# Fix the symlinks
chroot "$1" ln -sf /etc/dpkg/origins/ragnarok /etc/dpkg/origins/default
chroot "$1" ln -sf /usr/lib/os-release /etc/os-release

# Clean up the chroot
chroot "$1" apt clean
rm -rf "$1"/usr/src/ragnarok
rm -rf "$1"/var/lib/apt/lists/*
rm "$1"/var/log/apt/eipp.log.xz
rm "$1"/var/log/apt/history.log
rm "$1"/var/log/apt/term.log
rm "$1"/var/log/alternatives.log
rm "$1"/var/log/dpkg.log
rm "$1"/etc/hostname
rm "$1"/etc/resolv.conf
rm "$1"/tmp/*
for _file in /etc/machine-id /var/lib/dbus/machine-id; do
	if [ -f "${1}/${_file}" ]; then
		rm "${1}/${_file}"
	fi
done
