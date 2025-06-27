#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.11 2025/06/27 16:12:11 lecorbeau Exp $
#
# Extract and install the toolchain tarball to the chroot.

TARGET="$(getval MINIROOT config.mk)"

# Extract the toolchain if it is set to 'yes' in config.mk
if [ "$(getval TOOLCHAIN config.mk)" = "true" ]; then
	/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache"
	arch-chroot "${TARGET}" /bin/bash "PKGDIR=/var/cache/toolchain emerge -v --usepkg @llvm-toolchain"
	arch-chroot "${TARGET}" /bin/bash "PKGDIR=/var/cache/toolchain emerge -v --usepkg binutils gcc glibc"
	arch-chroot "${TARGET}" /bin/bash "PKGDIR=/var/cache/toolchain emerge -v --usepkg @build"
fi
