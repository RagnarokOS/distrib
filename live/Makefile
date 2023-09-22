# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Id: Makefile,v 1.1 2023/09/22 16:51:02 lecorbeau Exp $
#
# Work in progress

# Usage:
# 'make live-config' will create a live configuration.
# This should never be run as root.
#
# 'make iso' will build the iso.

include ../config.mk live.mk

NAME		= ${DISTRO}${VERSION}

all: live-config

# Using live-build for now.
# see: https://ragnarokos.github.io/logs/devnotes-june-2023.html
live-config:
	lb config \
		-d ${FLAVOUR} --debian-installer none \
		--iso-publisher "${PUBLISHER}" --initsystem sysvinit \
		--checksums sha512 --image-name ${NAME}-live \
		--hdd-label ${HDD_LABEL}_LIVE --iso-application ${PRETTY_NAME} \
		--iso-volume ${NAME} --archive-areas "${COMPONENTS}" \
		--debootstrap-options "--variant=${VARIANT}" \
		--bootappend-live "${LIVE_BOOTPARAMS}"
	cp -r ../../{src,x11} config/includes.chroot_after_packages/usr/src/ragnarok/
	cp ../../linux-image-${KERNEL}-ragnarok_${KERNEL}-ragnarok-1_amd64.deb config/packages.chroot/

# Equivalent to 'make install'
release: iso

iso:
	# We don't keep the bootloaders' configs in the repo
	cp -r /usr/share/live/build/bootloaders config/
	cp boot/grub.cfg config/bootloaders/grub-pc/
	cp boot/grub_splash.png config/bootloaders/grub-pc/splash.png
	cp boot/isolinux.cfg config/bootloaders/isolinux/
	# Generate the actual config for syslinux
	sed -i	-e "s#@PRETTY@#${PRETTY_NAME}#g" \
		-e "s#@MODE@#${ISO_MODE}#g" \
		-e "s#@PUBLISHER@#${PUBLISHER}#g" \
		-e "s#@DATE@#$(shell date +"%Y%m%d")#g" \
		-e "s#@VERSION@#${VERSION}#g" \
		-e "s#@CODENAME@#${CODENAME}#g" \
		-e "s#@LINUX_VERSION@#$(shell uname -r)#g" \
		config/bootloaders/syslinux_common/splash.svg
	# Set kernel version in the bootloaders' config files
	sed -i -e "s#@KERNEL@#${KERNEL}#g" config/bootloaders/isolinux/isolinux.cfg
	sed -i -e "s#@KERNEL@#${KERNEL}#g" config/bootloaders/grub-pc/grub.cfg
	sed -i -e "s#@DEBKERNEL@#${DEBKERNEL}#g" config/bootloaders/isolinux/isolinux.cfg
	sed -i -e "s#@DEBKERNEL@#${DEBKERNEL}#g" config/bootloaders/grub-pc/grub.cfg
	# Set date in /var/message/welcome.txt
	sed -i	-e "s|@DATE@|$(shell date)|g" \
		config/includes.chroot_after_packages/var/messages/welcome.txt
	lb build

# Not ready. Sign manually for now
#sign:
