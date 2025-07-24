#!/bin/sh

# $Ragnarok: 0006_extract.sh,v 1.7 2025/07/24 17:28:40 lecorbeau Exp $
# Extract the 'portage-git' and 'toolchain' tarballs.

TARGET="$(getval MINIROOT config.mk)"
DESTDIR="$(getval DESTDIR config.mk)"

if [ "$(getval TOOLCHAIN config.mk)" = "true" ]; then
	/usr/bin/tar xpvf toolchain.tgz -C "${DESTDIR}"
	/usr/bin/rsync -Klrv toolchain/ "${TARGET}/var/cache/binpkgs/"
	scripts/chrootcmd "${TARGET}" "emaint -f binhost"
	scripts/chrootcmd "${TARGET}" "emerge -v --usepkg llvm-core/clang"
	scripts/chrootcmd "${TARGET}" "emerge -v --usepkg binutils gcc glibc"
	scripts/chrootcmd "${TARGET}" "emerge -v --usepkg @llvm-toolchain"
	scripts/chrootcmd "${TARGET}" "emerge -v --usepkg @build"
fi

if [ "$(getval PORTAGE_GIT config.mk)" = "true" ]; then
	/usr/bin/tar xpvf portage-git.tgz -C "${DESTDIR}"
	/usr/bin/rsync -Klrv portage-git/ "${TARGET}/var/cache/binpkgs/"
	scripts/chrootcmd "${TARGET}" "/usr/bin/emaint -f binhost"
	scripts/chrootcmd "${TARGET}" "/usr/bin/emerge -v --usepkg app-eselect/eselect-repository dev-vcs/git"
fi
