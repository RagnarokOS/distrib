#!/bin/sh

# Customize before the setup phase
# $Ragnarok: setup01.sh,v 1.1 2023/10/17 17:03:11 lecorbeau Exp $

set -e

# Copy llvm.sources and gpg key to the chroot
mkdir -p "$1"/etc/apt
cp -r ../src/etc/apt/sources.list.d "$1"/etc/apt/
cp -r ../src/etc/apt/trusted.gpg.d/ "$1"/etc/apt/
