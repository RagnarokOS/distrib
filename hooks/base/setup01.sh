#!/bin/sh

# Customize before the setup phase
# $Ragnarok: setup01.sh,v 1.1 2024/06/28 15:51:35 lecorbeau Exp $

set -e

# Copy needed files from ragnarok-base.
mkdir -p "$1"/etc
mkdir -p "$1"/usr/bin
cp -r ../src/base/etc/apt/ "$1"/etc/

# Creating /etc/mailname. bsd-mailx and dma are installed non-interactively and we need
# this file to prevent dpkg from setting mailname to 'root' when dma is installed.
touch "$1"/etc/mailname
