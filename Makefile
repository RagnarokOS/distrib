# Makefile for creating Ragnarok iso/releases/chroots
# Work in progress

include config.mk

NAME		= ${DISTRO}${VERSION}
ISO_NAME	= ${NAME}-${ISOMODE}

release: minbase tarball iso sign

# Minbase is handled differently
minbase:

tarball:
	SOURCE_DATE_EPOCH=$(date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components=${COMPONENTS} \
			  --include=${PACKAGES} \
			  --hook-directory=${HOOK_DIR} \
			  ${PARENT} ${DESTDIR}/${NAME}.tgz

iso:
	mkdir -p ${DESTDIR}/iso/chroot
	# Test using tar2squashfs. If it works, don't extract the tarball at all.
	tar xpvf ${DESTDIR}/${NAME}.tgz --xattrs --xattrs-include='*' \
		-C ${DESTDIR}/iso/chroot
	# etc...

sign:
	/usr/bin/signify-openbsd -S -s ${SEC_KEY} -m ${NAME}.iso \
		-x ${NAME}.iso.sig
	/usr/bin/signify-openbsd -S -s ${SEC_KEY} -m ${ISO_NAME}.iso \
		-x ${ISO_NAME}.iso.sig
