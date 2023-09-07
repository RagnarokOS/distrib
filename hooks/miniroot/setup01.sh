#!/bin/sh

set -e

# Copy ragnarok.sources and the keys to the chroot
mkdir -p "$1"/etc/apt/sources.list.d
cp ../src/etc/apt/sources.list.d/ragnarok.sources "$1"/etc/apt/sources.list.d/
mkdir -p "$1"/usr/share/
cp -r ../src/usr/share/ragnarok-keys "$1"/usr/share/
