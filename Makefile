# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Ragnarok: Makefile,v 1.16 2024/05/07 15:40:02 lecorbeau Exp $
#
# Work in progress

include config.mk

NAME		= ${DISTRO}${VERSION}

all: live-config

live-config:
	make -C live live-config

release: miniroot iso

miniroot:
	/usr/bin/mmdebstrap --variant="${VARIANT}" \
		--components="${COMPONENTS}" \
		--include="${PACKAGES}" \
		--hook-directory=hooks/ \
		"${FLAVOUR}" miniroot${VERSION}.tgz \
		"deb https://ragnarokos.github.io/base/deb/ ${CODENAME} main" \
		"deb http://deb.debian.org/debian/ ${FLAVOUR} main non-free-firmware" \
		"deb http://security.debian.org/ ${FLAVOUR}-security main non-free-firmware" \
		"deb http://deb.debian.org/debian/ ${FLAVOUR}-updates main non-free-firmware"

iso:
	make -C live iso

# Not ready. Sign manually for now
sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
