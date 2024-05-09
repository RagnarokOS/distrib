#!/bin/sh

# Customize before the setup phase
# $Ragnarok: setup01.sh,v 1.6 2024/05/09 15:27:15 lecorbeau Exp $

set -e

# Copy needed files from ragnarok-base.
mkdir -p "$1"/etc
cp -r ../src/base/etc/apt/ "$1"/etc/
cp -r ../src/base/etc/dpkg "$1"/etc/
cp -r ../src/base/etc/signify "$1"/etc/
cp ../src/base/usr/bin/kernupd "$1"/usr/bin/

# Creating /etc/mailname. bsd-mailx and dma are installed non-interactively and we need
# this file to prevent dpkg from setting mailname to 'root' when dma is installed.
touch "$1"/etc/mailname
