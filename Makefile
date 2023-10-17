# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Ragnarok: Makefile,v 1.7 2023/10/17 15:16:00 lecorbeau Exp $
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

build:
	make -C ../src

# We're using a local apt repo and the packages' sig was
# already checked, so no need to re-check again.
miniroot: build
	/usr/bin/mmdebstrap --variant=${VARIANT} \
		--components="main non-free-firmware" \
		--include="${PACKAGES}" \
		--hook-directory="hooks/miniroot" \
		${FLAVOUR} miniroot${VERSION}.tgz

base:
	SOURCE_DATE_EPOCH=$(shell date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components="${COMPONENTS}" \
			  --include="${PACKAGES}" \
			  --hook-directory=${HOOK_DIR}/release \
			  ${FLAVOUR} ${DESTDIR}/${NAME}.tgz

iso:
	make -C live iso

# Not ready. Sign manually for now
sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
