# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# Work in progress

# Usage:
# 'make' will create a live configuration + the boot.tgz and x11.tgz sets.
# This should never be run as root.
#
# 'make release' will create miniroot.tgz, base.tgz and the ISOs. This is
# equivalent to 'Make install', so it must be run as root.

include config.mk live.mk

NAME		= ${DISTRO}${VERSION}
ISO_NAME	= ${NAME}-${ISO_MODE}

all: live-config boot x11

# Using live-build for now.
# see: https://ragnarokos.github.io/logs/devnotes-june-2023.html
live-config:
	# Creating config
	lb config \
		-d ${FLAVOUR} --debian-installer none \
		--iso-publisher "${PUBLISHER}" --initsystem sysvinit \
		--checksums sha512 --image-name ${NAME}-live \
		--hdd-label ${HDD_LABEL}_LIVE --iso-application ${PRETTY_NAME} \
		--iso-volume ${NAME} --archive-areas "${COMPONENTS}" \
		--debootstrap-options "--variant=${VARIANT}" \
		--bootappend-live "${BOOTPARAMS}"



release: miniroot base iso

miniroot:
	SOURCE_DATE_EPOCH=$(date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components="${COMPONENTS}" \
			  --include="${PACKAGES}" \
			  --hook-directory="${HOOK_DIR}/miniroot" \
			  ${FLAVOUR} ${DESTDIR}/miniroot${VERSION}.tgz

base:
	SOURCE_DATE_EPOCH=$(date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components="${COMPONENTS}" \
			  --include="${PACKAGES} ${RELEASE_PKGS}" \
			  --hook-directory=${HOOK_DIR}/release \
			  ${PARENT} ${DESTDIR}/${NAME}.tgz

iso:
	# We don't keep the bootloaders' configs in the repo
	mkdir -p config/bootloaders
	cp -r /usr/share/live/build/bootloaders config/
	cp splash/grub_splash.png config/bootloaders/grub-pc/splash.png
	cp splash/splash.svg.in config/bootloaders/syslinux_common/splash.svg
	# Generate the actual config for syslinux
	sed -i	-e "s#@PRETTY@#${PRETTY_NAME}#g" \
		-e "s#@MODE@#${ISO_MODE}#g" \
		-e "s#@PUBLISHER@#${PUBLISHER}#g" \
		-e "s#@DATE@#$(shell date +"%Y%m%d")#g" \
		-e "s#@VERSION@#${VERSION}#g" \
		-e "s#@CODENAME@#${CODENAME}#g" \
		-e "s#@LINUX_VERSION@#$(shell uname -r)#g" \
		config/bootloaders/syslinux_common/splash.svg
	# Set date in /var/message/welcome.txt
	sed -i	-e "s|@DATE@|$(shell date)|g" \
		config/includes.chroot_after_packages/var/messages/welcome.txt
	lb build

# Not ready. Sign manually for now
sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
