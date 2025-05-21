#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.6 2025/05/21 16:27:56 lecorbeau Exp $
#
# Extract the toolchain tarball to the chroot.

TARGET="$(awk '/DESTDIR/ { print $4 }' config.mk)/miniroot"

/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache"
