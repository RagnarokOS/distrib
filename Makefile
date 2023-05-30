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
	# Test using tar2sqfs. If it works, don't extract the tarball at all.
	tar xpvf ${DESTDIR}/${NAME}.tgz --xattrs --xattrs-include='*' \
		-C ${DESTDIR}/iso/chroot
	# etc...

sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
