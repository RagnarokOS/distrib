# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Ragnarok: Makefile,v 1.15 2024/04/23 15:34:23 lecorbeau Exp $
#
# Work in progress

include config.mk

NAME		= ${DISTRO}${VERSION}

all: live-config

live-config:
	make -C live live-config

release: miniroot iso

# Note: remove miniroot and base targets soon since they're built
# somewhere else now.
miniroot:
	chmod +x hooks/miniroot/customize02.sh
	/usr/bin/mmdebstrap --variant=${VARIANT} \
		--components="main non-free-firmware" \
		--include="${PACKAGES}" \
		--hook-directory="hooks/miniroot" \
		${FLAVOUR} miniroot${VERSION}.tgz \
		"deb https://ragnarokos.github.io/base/deb/ current main" \
		"deb https://ragnarokos.github.io/xserv/deb/ current main" \
		"deb http://deb.debian.org/debian/ bookworm main non-free-firmware" \
		"deb http://security.debian.org/ bookworm-security main non-free-firmware" \
		"deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware"

base:
	/usr/bin/mmdebstrap --variant=${VARIANT} \
		--components="main non-free-firmware" \
		--include="${BASE_PACKAGES}" \
		--hook-directory=hooks/base \
		${FLAVOUR} base${VERSION}.tgz \
		"deb https://ragnarokos.github.io/base/deb/ current main" \
		"deb https://ragnarokos.github.io/xserv/deb/ current main" \
		"deb http://deb.debian.org/debian/ bookworm main non-free-firmware" \
		"deb http://security.debian.org/ bookworm-security main non-free-firmware" \
		"deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware"

iso:
	make -C live iso

# Not ready. Sign manually for now
sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
