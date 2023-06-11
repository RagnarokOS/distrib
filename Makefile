# Makefile for creating Ragnarok iso/releases/chroots
# Work in progress

include config.mk

NAME		= ${DISTRO}${VERSION}
ISO_NAME	= ${NAME}-${ISO_MODE}

release: miniroot tarball iso sign

# Minbase is handled differently
miniroot:

tarball:
	SOURCE_DATE_EPOCH=$(date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components=${COMPONENTS} \
			  --include=${PACKAGES} \
			  --hook-directory=${HOOK_DIR} \
			  ${PARENT} ${DESTDIR}/${NAME}.tgz

# Using live-build for now. Not tested yet.
# see: https://ragnarokos.github.io/logs/devnotes-june-2023.html
iso:
	# Creating config
	lb config \
		-d ${FLAVOUR} --debian-installer none \
		--iso-publisher ${PUBLISHER} --inisystem sysvinit \
		--checksums sha512 --image-name ${ISO_NAME} \
		--hdd-label ${HDD_LABEL} --iso-application ${PRETTY_NAME} \
		--iso-volume ${NAME} --archive-areas \"${COMPONENTS}\" \
		--debootstrap-options \"variant=${VARIANT}\" \
		--bootappend-live ${BOOTPARAMS}

	# generating bootsplash
	sed -i	-e "s|@PRETTY@|${PRETTY_NAME}|g" \
		-e "s|@MODE@|${ISO_MODE}|g" \
		-e "s|@PUBLISHER@|${PUBLISHER}|g" \
		-e "s|@DATE@|$(shell date +"%Y%m%d")|g" \
		-e "s|@VERSION@|${VERSION}|g" \
		-e "s|@CODENAME@|$_codename|g" \
		-e "s|@LINUX_VERSION@|$_kernel|g" \
		config/bootloaders/syslinux_common/splash.svg



sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
