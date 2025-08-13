# Makefile for creating a build chroot.
# $Ragnarok: Makefile,v 1.2 2025/07/30 15:44:14 lecorbeau Exp $
#
# Work in progress

include ../config.mk

MAKE		= make -C
EXEC_DIR	= ${SRCDIR}/scripts
CHROOTDIR	= build${VERSION}

extract:
	mkdir ${CHROOTDIR}
	tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${CHROOTDIR}
	${EXEC_DIR}/runhooks hooks/buildchroot extract

# Configure portage.
portage-config:
	rsync -Klrv portage.conf/ ${CHROOTDIR}/
	${EXEC_DIR}/chrootcmd ${CHROOTDIR} "emerge --sync"

# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
buildchroot: extract portage-config
	${EXEC_DIR}/runhooks hooks/buildchroot setup
	${EXEC_DIR}/chrootcmd ${CHROOTDIR} "emerge -avuDN --with-bdeps=y @world"
	${EXEC_DIR}/runhooks hooks/buildchroot clean
	${EXEC_DIR}/mktar buildchroot

clean:
	${EXEC_DIR}/runhooks hooks/buildchroot clean

.PHONY: extract portage-config buildchroot clean
