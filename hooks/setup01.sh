#!/bin/sh

# Customize before the setup phase
# $Ragnarok: setup01.sh,v 1.4 2024/04/21 15:38:54 lecorbeau Exp $

set -e

# Copy apt sources and keys to the chroot
mkdir -p "$1"/etc/apt
cp -r ../src/ragnarok-base/etc/apt/sources.list.d "$1"/etc/apt/
cp -r ../src/ragnarok-base/etc/apt/trusted.gpg.d/ "$1"/etc/apt/

# Creating /etc/mailname. bsd-mailx and dma are installed non-interactively and we need
# this file to prevent dpkg from setting mailname to 'root' when dma is installed.
touch "$1"/etc/mailname
