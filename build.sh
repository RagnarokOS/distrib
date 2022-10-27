#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#											#
#	Copyright (c) 2022, Ian LeCorbeau <I-LeCorbeau (at) protonmail (dot) com>	#
#											#
#	Permission to use, copy, modify, and/or distribute this software for any	#
#	purpose with or without fee is hereby granted, provided that the above		#
#	copyright notice and this permission notice appear in all copies.		#
#											#
#	THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES	#
#	WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF		#
#	MERCHANTABILITY AND FITNESS IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR		#
#	ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES		#
#	WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN		#
#	ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF		#
#	OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.			#
#											#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

VERSION="dev"
BRANCH=-dev
BUILDER=LeCorbeau
DATE=$(date +"%Y%m%d")
FLAVOUR=bullseye
REPODIR="$HOME/.local/src/iso"
WORKDIR="$(mktemp -d -p /tmp ragnarok-XXXXXXXXXX)"
SRCDIR="$WORKDIR/config/includes.chroot_after_packages/usr/src"
SECKEY="$1"

mk_dirs() {
	echo "making dirs"
	mkdir -p "$WORKDIR"
	mkdir -p "$SRCDIR"
}

copy_files() {
	echo "copying files"
	# Copy config dir
	cp -r "$REPODIR"/config "$WORKDIR"/

	# We don't keep the bootloaders' configs in the repo
	mkdir -p "$WORKDIR"/config/bootloaders
	cp -r /usr/share/live/build/bootloaders/{grub-pc,isolinux,syslinux_common} "$WORKDIR"/config/bootloaders/
	cp "$REPODIR"/splash/grub_splash.png "$WORKDIR"/config/bootloaders/grub-pc/splash.png
	cp "$REPODIR"/splash/splash.svg.in "$WORKDIR"/config/bootloaders/syslinux_common/splash.svg

	# Git clone the src tree to the live system's /usr/src directory
	git -C "$SRCDIR" clone https://github.com/RagnarokOS/src.git

	# For the live iso, we can't use sh(1), else it messes up initramfs-tools
	sed -i -e '35d;36d' "$SRCDIR/src/bin/ksh/Makefile"

	git -C "$HOME"/.local/src/ clone https://github.com/RagnarokOS/equivs.git
	mkdir -p "$WORKDIR"/config/packages.chroot/ && \
		cp "$HOME"/.local/src/equivs/dummies/*.deb "$WORKDIR"/config/packages.chroot/

}

conf() {
	echo "config..."
	cd "$WORKDIR" || exit
	lb config \
		-d "$FLAVOUR" \
		--debian-installer none \
		--iso-publisher "$BUILDER" \
		--initsystem sysvinit \
		--checksums sha512 \
		--image-name ragnarok-"$VERSION"-live-"$DATE" \
		--hdd-label RAGNAROK_LIVE \
		--iso-application Ragnarok \
		--iso-volume Ragnarok-"$VERSION" \
		--archive-areas "main contrib non-free" \
		--debootstrap-options "--variant=minbase" \
		--bootappend-live "boot=live live-config.locales=en_CA.UTF-8 live.config-timezone=Canada/Eastern live-config.hostname=ragnarok live-config.noautologin live-config.sysv-rc=opensmtpd slab_nomerge init_on_alloc=1 init_on_free=1 page_alloc.shuffle=1 pti=on randomize_kstack_offset=on vsyscall=none debugfs=off lockdown=confidentiality"
}

# Generating splash.png for isolinux, based on splash.svg.in
gen_splash() {
	echo "generating splash"
	_kernel=$(uname -r)

	sed -i	-e "s#@BUILDER@#$BUILDER#g" \
		-e "s#@DATE@#$DATE#g" \
		-e "s#@VERSION@#$VERSION#g" \
		-e "s#@BRANCH@#$BRANCH#g" \
		-e "s#@LINUX_VERSION@#$_kernel#g" \
		"$WORKDIR"/config/bootloaders/syslinux_common/splash.svg
}

build() {
	echo "building iso..."
	cd "$WORKDIR" || exit
	# This script should not be run as root,
	# so we call doas here instead.
	/usr/bin/doas lb build
}

gen_sig() {
	local _seckey _pubkey _isoname
	
	# Full path to .sec and .pub Signify keys.
	# Never share the path to the .sec key.
	_seckey="$1"		# points to $SECKEY, which is this script's first and only argument.
	_pubkey="/etc/signify/ragnarok01.pub"

	_isoname=ragnarok-"$VERSION"-live-"$DATE"-amd64.hybrid.iso

	cd "$WORKDIR" || exit

	# Sign the file
	/usr/bin/signify-openbsd -S -s "$_seckey" -m "$_isoname" -x "$_isoname".sig

	# Verify for good measure
	/usr/bin/signify-openbsd -V -p "$_pubkey" -x "$_isoname".sig -m "$_isoname"
}

do_build() {
	mk_dirs
	copy_files
	conf
	gen_splash
	build
	gen_sig "$SECKEY"
}

if [ -z "$1" ]; then
	echo "Needs full path to signify sec key"
else
	do_build
fi
