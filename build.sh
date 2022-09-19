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

VERSION="0.1"
BRANCH=-dev
BUILDER=LeCorbeau
DATE=$(date +"%Y%m%d")
FLAVOUR=bullseye
REPODIR="$HOME"/.local/src/ragnarok/iso
WORKDIR="$HOME"/.build/ragnarok

usage() { 
	printf '%s\n' "Usage: build.sh <arg>

Arguments:
-d|--deploy	Do the first build.
-r|--rebuild	Rebuild/update the iso"
}

mk_dir() {
	mkdir -p "$WORKDIR"
}

conf() {
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
		--bootappend-live "boot=live live-config.hostname=ragnarok live-config.noautologin slab_nomerge init_on_alloc=1 init_on_free=1 page_alloc.shuffle=1 pti=on randomize_kstack_offset=on vsyscall=none debugfs=off lockdown=confidentiality"
}

copy_files() {
	cp -r "$REPODIR"/config/archives "$WORKDIR"/config/
	cp "$REPODIR"/config/hooks/normal/0001-instenv.hook.chroot "$WORKDIR"/config/hooks/normal/
	cp -r "$REPODIR"/config/includes.chroot_after_packages/ "$WORKDIR"/config/
	cp -r "$REPODIR"/config/package-lists/ "$WORKDIR"/config/

	# We don't keep the bootloaders' configs in the repo
	cp -r /usr/share/live/build/bootloaders/{grub-pc,isolinux,syslinux_common} "$WORKDIR"/config/bootloaders/
	cp "$REPODIR"/splash/grub_splash.png "$WORKDIR"/config/bootloaders/grub-pc/splash.png
}

# No need to keep dummy packages in two repositories, so they are fetched
# from src then moved to the build directory in config/packages.chroot/
fetch_dummies() {
	/usr/bin/curl -OL https://github.com/RagnarokOS/src/raw/main/dummy-packages/man-db_99_all/man-db_99_all.deb
	mv man-db_99_all.deb "$WORKDIR"/config/packages.chroot/
}

# Generating splash.png for isolinux, based on splash.svg.in
gen_splash() {
	_kernel=$(uname -r)

	cp "$REPODIR"/splash/splash.svg.in "$WORKDIR"/config/bootloaders/syslinux_common/splash.svg
	sed -i	-e "s#@BUILDER@#$BUILDER#g" \
		-e "s#@DATE@#$DATE#g" \
		-e "s#@VERSION@#$VERSION#g" \
		-e "s#@BRANCH@#$BRANCH#g" \
		-e "s#@KERNEL@#$_kernel#g" \
		"$WORKDIR"/config/bootloaders/syslinux_common/splash.svg
}

gen_sig() {
	local _seckey _pubkey _isoname
	
	# Full path to .sec and .pub Signify keys.
	# Never share the path to the .sec key.
	_seckey=/path/to/key.sec	# change for real path
	_pubkey="$HOME"/.sig/ragnarok01.pub

	_isoname=ragnarok-"$VERSION"-live-"$DATE"-amd64.hybrid.iso

	cd "$WORKDIR" || exit

	# Sign the file
	/usr/bin/signify-openbsd -S -s "$_seckey" -m "$_isoname" -x "$_isoname".sig

	# Verify for good measure
	/usr/bin/signify-openbsd -V -p "$_pubkey" -x "$_isoname".sig -m "$_isoname"
}

do_conf() {
	mk_dir
	conf
	copy_files
	gen_splash
}

do_build() {
	cd "$WORKDIR" || exit
	/usr/bin/doas lb build
	gen_sig
}

do_rebuild() {
	gen_splash
	sleep 1			# Just in case
	cd "$WORKDIR" || exit
	/usr/bin/doas lb clean
	lb config --image-name ragnarok-"$VERSION"-live-"$DATE"
	/usr/bin/doas lb build
}

case "$1" in
	-d|--deploy)	do_conf
			do_build ;;
	-r|--rebuild)	do_rebuild ;;
	*) 		usage ;;
esac
