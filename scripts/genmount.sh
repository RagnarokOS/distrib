#!/bin/sh

# $Ragnarok: genmount.sh,v 1.1 2025/03/21 16:05:42 lecorbeau Exp $
# Mount devices to the chroot.

MNT_PATH="$1"

if [ -z "$1" ]; then
	printf '%s\n' "You must provide the mount point as arg 1."
	exit 1
fi

cp --dereference /etc/resolv.conf "${MNT_PATH}/etc/"
mount --types proc /proc "${MNT_PATH}"/proc
mount --rbind /sys "${MNT_PATH}"/sys
mount --make-rslave "${MNT_PATH}"/sys
mount --rbind /dev "${MNT_PATH}"/dev
mount --make-rslave "${MNT_PATH}"/dev
mount --bind /run "${MNT_PATH}"/run
mount --make-slave "${MNT_PATH}"/run
