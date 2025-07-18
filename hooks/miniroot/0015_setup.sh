#!/bin/sh

# $Ragnarok: 0015_setup.sh,v 1.13 2025/07/18 17:26:12 lecorbeau Exp $
#
# Extract and install the toolchain tarball to the chroot.

TARGET="$(getval MINIROOT config.mk)"

# Extract the toolchain if it is set to 'yes' in config.mk
if [ "$(getval TOOLCHAIN config.mk)" = "true" ]; then
	/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache/binpkgs/"
	./chrootcmd "${TARGET}" "emaint -f binhost"
	./chrootcmd "${TARGET}" "emerge -v --usepkg @llvm-toolchain"
	./chrootcmd "${TARGET}" "emerge -v --usepkg binutils gcc glibc"
	./chrootcmd "${TARGET}" "emerge -v --usepkg @build"
fi
