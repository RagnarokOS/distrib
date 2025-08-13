#!/bin/sh

# $Ragnarok: 0100_clean.sh,v 1.1 2025/06/25 18:10:32 lecorbeau Exp $
#
# Cleanup miniroot before creating tarball.

set -e

TARGET="$(getval MINIROOT config.mk)"

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
