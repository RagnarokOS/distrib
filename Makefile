# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Ragnarok: Makefile,v 1.12 2024/03/08 19:12:52 lecorbeau Exp $
#
# Work in progress

include config.mk

NAME		= ${DISTRO}${VERSION}

all: live-config

# Using live-build for now.
# see: https://ragnarokos.github.io/logs/devnotes-june-2023.html
live-config:
	make -C live live-config

release: miniroot iso

# Note: trusted=yes is not a security concern. The repo's tgz is
# signed with signify and the sig is verified before it gets extracted.
miniroot:
	chmod +x hooks/miniroot/customize02.sh
	/usr/bin/mmdebstrap --variant=${VARIANT} \
		--components="main non-free-firmware" \
		--include="${PACKAGES}" \
		--hook-directory="hooks/miniroot" \
		${FLAVOUR} miniroot${VERSION}.tgz \
		"deb https://ragnarokos.github.io/base/deb/ current main" \
		"deb http://deb.debian.org/debian/ bookworm main non-free-firmware" \
		"deb http://security.debian.org/ bookworm-security main non-free-firmware" \
		"deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware"

base:
	/usr/bin/mmdebstrap --variant=${VARIANT} \
		--components="main non-free-firmware" \
		--include="${PACKAGES}" \
		--hook-directory=hooks/base \
		${FLAVOUR} base${VERSION}.tgz

iso:
	make -C live iso

# Not ready. Sign manually for now
sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
