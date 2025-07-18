#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.12 2025/07/18 16:19:44 lecorbeau Exp $
#
# Extract and install the toolchain tarball to the chroot.

TARGET="$(getval MINIROOT config.mk)"

# Extract the toolchain if it is set to 'yes' in config.mk
if [ "$(getval TOOLCHAIN config.mk)" = "true" ]; then
	/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache"
	./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg @llvm-toolchain"
	./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg binutils gcc glibc"
	./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg @build"
fi
