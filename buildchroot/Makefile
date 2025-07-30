# Makefile for creating Ragnarok miniroot.
# $Ragnarok: Makefile,v 1.1 2025/07/29 15:49:50 lecorbeau Exp $
#
# Work in progress

include ../config.mk

MAKE		= make -C
EXEC_DIR	= ${SRCDIR}/scripts

extract:
	mkdir ${MINIROOT}
	tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${MINIROOT}
	${EXEC_DIR}/runhooks hooks/miniroot extract

# Configure portage.
portage-config:
	rsync -Klrv portage.conf/ ${MINIROOT}/
	${EXEC_DIR}/chrootcmd ${MINIROOT} "emerge --sync"

# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot: extract portage-config
	${EXEC_DIR}/runhooks hooks/miniroot setup
	${EXEC_DIR}/chrootcmd ${MINIROOT} "emerge -avuDN --with-bdeps=y @world"
	${EXEC_DIR}/runhooks hooks/miniroot clean
	${EXEC_DIR}/mktar miniroot

clean:
	${EXEC_DIR}/runhooks hooks/miniroot clean

.PHONY: extract portage-config miniroot clean
