# Makefile for creating Ragnarok iso/releases/chroots
# Work in progress

include config.mk iso.mk

NAME		= ${DISTRO}${VERSION}
ISO_NAME	= ${NAME}-${ISO_MODE}

release: miniroot tarball iso sign

miniroot:
	SOURCE_DATE_EPOCH=$(date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components=${COMPONENTS} \
			  --include=${PACKAGES} \
			  --hook-directory=${HOOK_DIR}/miniroot \
			  ${PARENT} ${DESTDIR}/miniroot${VERSION}.tgz

tarball:
	SOURCE_DATE_EPOCH=$(date +%s) /usr/bin/mmdebstrap --variant=${VARIANT} \
			  --components=${COMPONENTS} \
			  --include=${PACKAGES} ${RELEASE_PKGS} \
			  --hook-directory=${HOOK_DIR}/release \
			  ${PARENT} ${DESTDIR}/${NAME}.tgz

# Using live-build for now. Not tested yet.
# see: https://ragnarokos.github.io/logs/devnotes-june-2023.html
live-config:
	# Creating config
	lb config \
		-d ${FLAVOUR} --debian-installer none \
		--iso-publisher ${PUBLISHER} --inisystem sysvinit \
		--checksums sha512 --image-name ${NAME}-live \
		--hdd-label ${HDD_LABEL}_LIVE --iso-application ${PRETTY_NAME} \
		--iso-volume ${NAME} --archive-areas \"${COMPONENTS}\" \
		--debootstrap-options \"variant=${VARIANT}\" \
		--bootappend-live ${BOOTPARAMS}

iso:
	# generating bootsplash
	sed -i	-e "s|@PRETTY@|${PRETTY_NAME}|g" \
		-e "s|@MODE@|${ISO_MODE}|g" \
		-e "s|@PUBLISHER@|${PUBLISHER}|g" \
		-e "s|@DATE@|$(shell date +"%Y%m%d")|g" \
		-e "s|@VERSION@|${VERSION}|g" \
		-e "s|@CODENAME@|${CODENAME}|g" \
		-e "s|@LINUX_VERSION@|$(shell uname -r)|g" \
		config/bootloaders/syslinux_common/splash.svg
	# Feed /var/messages/welcome.txt with info
	sed -i	-e "s|@VERSION@|${VERSION}|g" \
		-e "s|@CODENAME@|${CODENAME}|g" \
		-e "s|@PUBLISHER@|${PUBLISHER}|g" \
		-e "s|@DATE@|$(shell date +"%Y%m%d")|g" \
		/var/messages/welcome.txt
	lb build

sign:
	/usr/bin/mksig ${NAME}.tgz
	/usr/bin/mksig ${ISO_NAME}.iso
