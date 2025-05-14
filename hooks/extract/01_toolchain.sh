#!/bin/sh

# Extract the toolchain tarball to the chroot.

TARGET="$(awk '/DESTDIR/ { print $4 }' config.mk)/miniroot"

/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache"
