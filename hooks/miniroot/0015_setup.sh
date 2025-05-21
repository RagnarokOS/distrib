#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.7 2025/05/21 17:53:13 lecorbeau Exp $
#
# Extract and install the toolchain tarball to the chroot.

TARGET="$(getval DESTDIR config.mk)/miniroot"

/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache"
./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg @llvm-toolchain"
./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg binutils gcc glibc"
./chrootcmd "${TARGET}" "PKGDIR=/var/cache/toolchain emerge -v --usepkg @build"
