# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.54 2025/07/30 15:50:08 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE		= make -C
EXEC_DIR	= ${SRCDIR}/scripts

depends:
	${EXEC_DIR}/checkdep

extract:
	mkdir ${MINIROOT}
	tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${MINIROOT}
	${EXEC_DIR}/runhooks hooks/miniroot extract

# Configure portage.
portage-config:
	rsync -Klrv portage.conf/ ${MINIROOT}/
	${EXEC_DIR}/chrootcmd ${MINIROOT} "emerge --sync"

buildchroot:
	${MAKE} buildchroot buildchroot

# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot: extract portage-config
	${EXEC_DIR}/runhooks hooks/miniroot setup
	${EXEC_DIR}/chrootcmd ${MINIROOT} "emerge -avuDN --with-bdeps=y @world"
	${EXEC_DIR}/runhooks hooks/miniroot clean
	${EXEC_DIR}/mktar miniroot

# Base is built using miniroot
base:
	mkdir ${BASE}
	tar xpvf miniroot${VERSION}.tgz --xattrs-include='*.*' --numeric-owner -C ${BASE}
	rsync -Klrv includes.preinst/ ${BASE}/ || true
	${EXEC_DIR}/runhooks hooks/base configure
	${EXEC_DIR}/chrootcmd ${BASE} "emerge -v sys-apps/ragnarok-base"
	rsync -Klrv includes.postinst/ ${BASE} || true

release: miniroot base

clean-miniroot:
	${EXEC_DIR}/runhooks hooks/miniroot clean

clean: clean-miniroot

.PHONY: miniroot
