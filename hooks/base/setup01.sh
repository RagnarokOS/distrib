#!/bin/sh

# Customize before the setup phase
# $Ragnarok: setup01.sh,v 1.2 2024/11/09 20:35:36 lecorbeau Exp $

set -e

# Copy needed files from ragnarok-base.
mkdir -p "$1"/etc
mkdir -p "$1"/usr/bin
mkdir -p "$1"/usr/share/keyrings
cp -r ../src/base/etc/apt/ "$1"/etc/
cp ../src/base/usr/share/ragnarok/keyrings/brave-browser-archive-keyring.gpg "$1"/usr/share/keyrings/
chmod 644 /usr/share/keyrings/brave-browser-archive-keyring.gpg

# Creating /etc/mailname. bsd-mailx and dma are installed non-interactively and we need
# this file to prevent dpkg from setting mailname to 'root' when dma is installed.
touch "$1"/etc/mailname
