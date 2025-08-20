#!/bin/sh

# $Ragnarok: 0005_extract.sh,v 1.4 2025/08/20 16:03:39 lecorbeau Exp $

TARGET="$1"

# Copy Ragnarok's Signify and PGP public keys to the chroot.
cp /usr/share/openpgp-keys/lecorbeau.asc "${TARGET}/usr/share/openpgp-keys/"
cp -r /etc/signify "${TARGET}/etc/"
