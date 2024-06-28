# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Ragnarok: Makefile,v 1.21 2024/06/28 18:07:33 lecorbeau Exp $
#
# Work in progress

include config.mk

NAME		= ${DISTRO}${VERSION}

all: live-config

live-config:
	make -C iso live-config

miniroot:
	/usr/bin/mmdebstrap --variant="${VARIANT}" \
		--components="${COMPONENTS}" \
		--include="${PACKAGES}" \
		--hook-directory=hooks/ \
		"${FLAVOUR}" miniroot${VERSION}.tgz \
		"deb https://ragnarokos.github.io/base/deb/ ${VERSION} main" \
		"deb http://deb.debian.org/debian/ ${FLAVOUR} main non-free-firmware" \
		"deb http://security.debian.org/ ${FLAVOUR}-security main non-free-firmware" \
		"deb http://deb.debian.org/debian/ ${FLAVOUR}-updates main non-free-firmware"

base:
	/usr/bin/mmdebstrap --variant="${VARIANT}" \
		--components="${COMPONENTS}" \
		--include="${PACKAGES}" \
		--hook-directory=hooks/base \
		"${FLAVOUR}" base${VERSION}.tgz \
		"deb https://ragnarokos.github.io/base/deb/ ${VERSION} main" \
		"deb http://deb.debian.org/debian/ ${FLAVOUR} main non-free-firmware" \
		"deb http://security.debian.org/ ${FLAVOUR}-security main non-free-firmware" \
		"deb http://deb.debian.org/debian/ ${FLAVOUR}-updates main non-free-firmware"

iso:
	make -C iso iso

tarball: miniroot base

release: tarball iso

# Not ready. Sign manually for now
sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso

.PHONY: miniroot base iso release tarball
