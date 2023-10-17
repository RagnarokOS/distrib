# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Ragnarok: Makefile,v 1.9 2023/10/17 17:45:38 lecorbeau Exp $
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

# We're using a local apt repo and the packages' sig was
# already checked, so no need to re-check again.
miniroot:
	/usr/bin/mmdebstrap --variant=${VARIANT} \
		--components="main non-free-firmware" \
		--include="${PACKAGES}" \
		--hook-directory="hooks/miniroot" \
		${FLAVOUR} miniroot${VERSION}.tgz

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
