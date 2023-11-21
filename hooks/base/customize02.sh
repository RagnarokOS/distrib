#!/bin/sh

# build src
# $Ragnarok: customize02.sh,v 1.9 2023/11/21 17:04:18 lecorbeau Exp $

set -e

# Install the packages that are not yet built from source
chroot "$1" apt-get install -y build-essential git sysvinit-core sysv-rc orphan-sysvinit-scripts \
	elogind libpam-elogind procps libarchive-tools nftables rsyslog logrotate ifupdown \
	wpasupplicant console-data kbd tmux vim bsdextrautils libpam0g-dev libssl-dev \
	liblockfile-dev

# Build src
# Check if make was already run (if miniroot was built right before) and only run if it wasn't
if [ ! -f "../src/bin/oksh/alloc.o" ]; then
	make -C ../src -j"$(nproc)"
fi
make -C ../src DESTDIR="$1" install
