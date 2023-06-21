#!/bin/sh

set -e

# Copy ragnarok.sources to the chroot
mkdir -p "$1"/etc/apt/sources.list.d
cp /etc/apt/sources.list.d/ragnarok.sources "$1"/etc/apt/sources.list.d/

# We also need to copy the keys to the chroot, since the ragnarok-files package (which provides
# the keys) isn't installed yet, and won't install if the keys aren't already present to verify
# the package's signature.
mkdir -p "$1"/usr/share/
cp -r /usr/share/ragnarok-keys "$1"/usr/share/

# Creating /etc/mailname. bsd-mailx and dma are installed non-interactively and we need
# this file to prevent dpkg from setting mailname to 'root' when dma is installed.
touch "$1"/etc/mailname
