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

all: cli x11

# Using live-build for now.
# see: https://ragnarokos.github.io/logs/devnotes-june-2023.html
cli:
	# Creating cli config
	cd live-cli; \
	lb config \
		-d ${FLAVOUR} --debian-installer none \
		--iso-publisher "${PUBLISHER}" --initsystem sysvinit \
		--checksums sha512 --image-name ${NAME}-live-cli \
		--hdd-label ${HDD_LABEL}_LIVE --iso-application ${PRETTY_NAME} \
		--iso-volume ${NAME} --archive-areas "${COMPONENTS}" \
		--debootstrap-options "--variant=${VARIANT}" \
		--bootappend-live "${CLI_BOOTPARAMS}"

x11:
	# Creating X11 config
	cd live-x11 \
	lb config \
		-d ${FLAVOUR} --debian-installer none \
		--iso-publisher "${PUBLISHER}" --initsystem sysvinit \
		--checksums sha512 --image-name ${NAME}-live-x11 \
		--hdd-label ${HDD_LABEL}_LIVE --iso-application ${PRETTY_NAME} \
		--iso-volume ${NAME} --archive-areas "${COMPONENTS}" \
		--debootstrap-options "--variant=${VARIANT}" \
		--bootappend-live "${X11_BOOTPARAMS}"

iso:
	# We don't keep the bootloaders' configs in the repo
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
