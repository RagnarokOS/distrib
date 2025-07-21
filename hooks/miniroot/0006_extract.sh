#!/bin/sh

# $Ragnarok: 0006_extract.sh,v 1.2 2025/07/21 17:33:56 lecorbeau Exp $
# Extract the 'portage-git' and 'toolchain' tarballs.

TARGET="$(getval MINIROOT config.mk)"

if [ "$(getval PORTAGE_GIT config.mk)" = "true" ]; then
	/usr/bin/tar xpvf portage-git.tgz -C "${TARGET}/var/cache/binpkgs/"
	/usr/bin/emaint -f binhost
fi

if [ "$(getval TOOLCHAIN config.mk)" = "true" ]; then
	/usr/bin/tar xpvf toolchain.tgz -C "${TARGET}/var/cache/binpkgs/"
	./chrootcmd "${TARGET}" "emaint -f binhost"
	./chrootcmd "${TARGET}" "emerge -v --usepkg @llvm-toolchain"
	./chrootcmd "${TARGET}" "emerge -v --usepkg binutils gcc glibc"
	./chrootcmd "${TARGET}" "emerge -v --usepkg @build"
fi
