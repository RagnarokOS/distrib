#!/bin/sh

# $Ragnarok: 0006_extract.sh,v 1.4 2025/07/22 16:21:19 lecorbeau Exp $
# Extract the 'portage-git' and 'toolchain' tarballs.

TARGET="$(getval MINIROOT config.mk)"
DESTDIR="$(getval DESTDIR config.mk)"

if [ "$(getval PORTAGE_GIT config.mk)" = "true" ]; then
	/usr/bin/tar xpvf portage-git.tgz -C "${DESTDIR}"
	/usr/bin/rsync -Klrv portage-git/ "${TARGET}/var/cache/binpkgs/"
	./chrootcmd "${TARGET}" "/usr/bin/emaint -f binhost"
	./chrootcmd "${TARGET}" "/usr/bin/emerge -v app-eselect/eselect-repository dev-vcs/git"
fi

if [ "$(getval TOOLCHAIN config.mk)" = "true" ]; then
	/usr/bin/tar xpvf toolchain.tgz -C "${DESTDIR}"
	/usr/bin/rsync -Klrv toolchain/ "${TARGET}/var/cache/binpkgs/"
	./chrootcmd "${TARGET}" "emaint -f binhost"
	./chrootcmd "${TARGET}" "emerge -v --usepkg clang"
	./chrootcmd "${TARGET}" "emerge -v --usepkg binutils gcc glibc"
	./chrootcmd "${TARGET}" "emerge -v --usepkg @llvm-toolchain"
	./chrootcmd "${TARGET}" "emerge -v --usepkg @build"
fi
