#!/bin/sh

# build src
# $Ragnarok: customize02.sh,v 1.8 2023/11/21 16:44:21 lecorbeau Exp $

set -e

# Build src
# Check if make was already run (if miniroot was built right before) and only run if it wasn't
if [ ! -f "../src/bin/oksh/alloc.o" ]; then
	make -C ../src -j"$(nproc)"
fi
make -C ../src DESTDIR="$1" install
