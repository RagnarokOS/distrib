#!/bin/sh

# $Ragnarok: 0006_extract.sh,v 1.1 2025/07/21 17:30:37 lecorbeau Exp $
# Extract the 'portage-git' and 'toolchain' tarballs.

TARGET="$(getval MINIROOT config.mk)"

if [ "$(getval PORTAGE_GIT config.mk)" = "true" ]; then
	/usr/bin/tar xpvf portage-git.tgz -C "${TARGET}/var/cache/binpkgs/"
	/usr/bin/emaint -f binhost
fi
