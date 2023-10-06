# Makefile for creating Ragnarok iso/releases/miniroot/sets.
# $Ragnarok: Makefile,v 1.2 2023/10/06 23:17:14 lecorbeau Exp $
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

miniroot:
	/usr/sbin/debootstrap --variant=${VARIANT} \
		# We're using a local apt repo and the packages' sig was
		# already checked, so no need to re-check again.
		--no-check-gpg \
		--include="${PACKAGES}" \
		${FLAVOUR} ${DESTDIR}/miniroot${VERSION} \
		file:///usr/src/repo

base:
	SOURCE_DATE_EPOCH=$(shell date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components="${COMPONENTS}" \
			  --aptopt='Apt::Install-Recommends "true"' \
			  --include="${PACKAGES} ${RELEASE_PKGS}" \
			  --hook-directory=${HOOK_DIR}/release \
			  ${FLAVOUR} ${DESTDIR}/${NAME}.tgz

iso:
	make -C live iso

# Not ready. Sign manually for now
sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
