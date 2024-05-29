#!/bin/sh

# Customize before the setup phase
# $Ragnarok: setup01.sh,v 1.8 2024/05/29 15:11:36 lecorbeau Exp $

set -e

# Copy needed files from ragnarok-base.
mkdir -p "$1"/etc
mkdir -p "$1"/usr/bin
cp -r ../src/base/etc/apt/ "$1"/etc/
cp -r ../src/base/etc/dpkg "$1"/etc/
cp -r ../src/base/etc/signify "$1"/etc/
cp ../src/base/usr/bin/kernupd "$1"/usr/bin/
cp ../src/base/usr/lib/ragnarok-shlib "$1"/usr/lib/

# Creating /etc/mailname. bsd-mailx and dma are installed non-interactively and we need
# this file to prevent dpkg from setting mailname to 'root' when dma is installed.
touch "$1"/etc/mailname
