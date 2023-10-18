#!/bin/sh

# build src
# $Ragnarok: customize02.sh,v 1.7 2023/10/18 18:26:50 lecorbeau Exp $

set -e

# Build src
make -C ../src -j"$(nproc)"
make -C ../src DESTDIR="$1" miniroot
