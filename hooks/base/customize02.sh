#!/bin/sh

set -e

# Clean up the chroot
# $Ragnarok: customize02.sh,v 1.2 2024/06/30 15:40:53 lecorbeau Exp $

printf '%s\n' "Cleaning up the chroot..."

# Using the repo with mmdebstrap will set it up in the chroot's /etc/apt/sources.list
# file, but it's already copied to its own file in /etc/apt/sources.list.d/, so remove
# the duplicate
sed -i '/ragnarokos/d' "$1"/etc/apt/sources.list

# Do the cleanup
chroot "$1" apt clean
echo "ragnarok" > "$1"/etc/hostname
sed -i '2i 127.0.1.1\tragnarok\n' "$1"/etc/hosts
rm -rf "$1"/var/lib/apt/lists/*
rm "$1"/var/log/apt/eipp.log.xz
rm "$1"/var/log/apt/history.log
rm "$1"/var/log/apt/term.log
rm "$1"/var/log/alternatives.log
rm "$1"/var/log/dpkg.log
rm "$1"/etc/resolv.conf
rm "$1"/tmp/*
for _file in /etc/machine-id /var/lib/dbus/machine-id; do
	if [ -f "${1}/${_file}" ]; then
		rm "${1}/${_file}"
	fi
done
