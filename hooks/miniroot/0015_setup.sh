#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.8 2025/05/27 16:17:50 lecorbeau Exp $
#
# Extract and install the toolchain tarball to the chroot.

TARGET="$(getval MINIROOT config.mk)"

/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache"
./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg @llvm-toolchain"
./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg binutils gcc glibc"
./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg @build"
