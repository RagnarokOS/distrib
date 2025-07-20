#!/bin/sh

# $Ragnarok: 0005_extract.sh,v 1.1 2025/07/20 15:24:06 lecorbeau Exp $

TARGET="$(getval MINIROOT config.mk)"

# Copy Ragnarok's public key PGP key if TOOLCHAIN = "true".
if [ "$(getval TOOLCHAIN config.mk)" = "true" ]; then
	cp /usr/share/openpgp-keys/lecorbeau.asc "${TARGET}/usr/share/openpgp-keys/"
fi
