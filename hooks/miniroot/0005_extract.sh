#!/bin/sh

# $Ragnarok: 0005_extract.sh,v 1.2 2025/07/22 16:08:08 lecorbeau Exp $

TARGET="$(getval MINIROOT config.mk)"

# Copy Ragnarok's Signify and PGP public keys to the chroot.
cp /usr/share/openpgp-keys/lecorbeau.asc "${TARGET}/usr/share/openpgp-keys/"
cp -r /etc/signify "${TARGET}/etc/"
