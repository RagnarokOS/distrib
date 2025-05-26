#!/bin/sh

# $Ragnarok: 0100_cleanup.sh,v 1.2 2025/05/26 17:23:51 lecorbeau Exp $
#
# Cleanup miniroot before creating tarball.

set -e

TARGET="$(getval DESTDIR config.mk)/miniroot"

# Start by removing resolv.conf, if it exists.
if [ -f "${TARGET}/etc/resolv.conf" ]; then
	rm -f "${TARGET}/etc/resolv.conf"
fi

# rm root's .bash_history
rm "${TARGET}/root/.bash_history"

# Cleanup /var
for _dir in lock log run tmp cache/distfiles; do
	rm -rf "${TARGET}/var/${_dir}/*"
done
rm -rf "${TARGET}/var/db/repos/*/*"
