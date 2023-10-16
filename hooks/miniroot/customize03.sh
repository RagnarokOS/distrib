#!/bin/sh

set -e

# Clean up the chroot
# $Ragnarok: customize03.sh,v 1.1 2023/10/16 17:05:15 lecorbeau Exp $

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
