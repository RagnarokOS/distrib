#!/bin/sh

# $Ragnarok: 0100_clean.sh,v 1.2 2025/08/20 16:06:29 lecorbeau Exp $
#
# Cleanup miniroot before creating tarball.

set -e

TARGET="$1"

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
