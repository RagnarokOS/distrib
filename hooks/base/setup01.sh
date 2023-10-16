#!/bin/sh

# Customize before the setup phase
# $Ragnarok: setup01.sh,v 1.1 2023/10/16 15:49:48 lecorbeau Exp $

set -e

# Copy llvm.sources and gpg key to the chroot
mkdir -p "$1"/etc/apt
cp -r ../src/etc/apt/sources.list.d "$1"/etc/apt/
cp -r ../src/etc/apt/trusted.gpg.d/ "$1"/etc/apt/

# Creating /etc/mailname. bsd-mailx and dma are installed non-interactively and we need
# this file to prevent dpkg from setting mailname to 'root' when dma is installed.
touch "$1"/etc/mailname
