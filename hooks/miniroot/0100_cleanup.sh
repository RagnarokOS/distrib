#!/bin/sh

# $Ragnarok: 0100_cleanup.sh,v 1.1 2025/05/26 15:49:22 lecorbeau Exp $
#
# Cleanup miniroot before creating tarball.

TARGET="$(getval DESTDIR config.mk)/miniroot"

# Start by removing resolv.conf, if it exists.
if [ -f "${TARGET}/etc/resilv.conf" ]; then
	rm -f "${TARGET}/etc/resolv.conf"
fi


