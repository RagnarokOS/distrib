# Makefile for creating Ragnarok's installer ISO.
# $Ragnarok: Makefile,v 1.5 2024/11/13 23:37:22 lecorbeau Exp $
#
# Work in progress

# Usage:
# 'make live-config' will create a live configuration.
# This should never be run as root.
#
# 'make iso' will build the iso.

include ../../config.mk ../live.mk

all: installer-config

# Let's test this new method.
installer-config:
	lb config \
		-d ${FLAVOUR} --debian-installer none \
		--iso-publisher "${PUBLISHER}" --initsystem sysvinit \
		--checksums sha512 --image-name install${VERSION} \
		--hdd-label ${HDD_LABEL} --iso-application ${PRETTY_NAME} \
		--iso-volume ${NAME} --archive-areas "${COMPONENTS}" \
		--debootstrap-options "--variant=${VARIANT}" \
		--system normal --cache false
	touch .build/bootstrap
	mkdir -p chroot

iso:
	# We don't keep the bootloaders' configs in the repo
	cp -r /usr/share/live/build/bootloaders config/
	cp ../boot/grub-installer.cfg config/bootloaders/grub-pc/grub.cfg
	cp ../boot/grub_splash.png config/bootloaders/grub-pc/splash.png
	cp ../boot/isolinux-installer.cfg config/bootloaders/isolinux/isolinux.cfg
	# Generate the actual config for syslinux
	sed -i	-e "s#@PRETTY@#${PRETTY_NAME}#g" \
		-e "s#@MODE@#${ISO_MODE}#g" \
		-e "s#@PUBLISHER@#${PUBLISHER}#g" \
		-e "s#@DATE@#$(shell date +"%Y%m%d")#g" \
		-e "s#@VERSION@#${VERSION}#g" \
		-e "s#@CODENAME@#${CODENAME}#g" \
		-e "s#@LINUX_VERSION@#${KERNEL}-amd64#g" \
		config/bootloaders/syslinux_common/splash.svg
	# Set kernel version in the bootloaders' config files
	sed -i -e "s#@KERNEL@#${KERNEL}#g" config/bootloaders/isolinux/isolinux.cfg
	sed -i -e "s#@KERNEL@#${KERNEL}#g" config/bootloaders/grub-pc/grub.cfg
	sed -i -e "s#@DEBKERNEL@#${DEBKERNEL}#g" config/bootloaders/isolinux/isolinux.cfg
	sed -i -e "s#@DEBKERNEL@#${DEBKERNEL}#g" config/bootloaders/grub-pc/grub.cfg
	tar xzpvf ../../miniroot${VERSION}.tgz --xattrs --xattrs-include='*' --numeric-owner -C chroot/
	lb chroot
	lb binary

# Not ready. Sign manually for now
#sign:
