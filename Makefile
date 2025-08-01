# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.56 2025/07/31 19:07:50 lecorbeau Exp $
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
	${EXEC_DIR}/chrootcmd ${MINIROOT} "emerge -ask --verbose --empty-tree --with-bdeps=y --usepkg @world"
	${EXEC_DIR}/runhooks hooks/miniroot clean
	${EXEC_DIR}/mktar miniroot

# Base is built using miniroot
base:
	mkdir ${BASE}
	tar xpvf miniroot${VERSION}.tar.xz --xattrs-include='*.*' --numeric-owner -C ${BASE}
	rsync -Klrv includes.preinst/ ${BASE}/ || true
	${EXEC_DIR}/runhooks hooks/base configure
	${EXEC_DIR}/chrootcmd ${BASE} "emerge -v sys-apps/ragnarok-base"
	rsync -Klrv includes.postinst/ ${BASE} || true

release: miniroot base

clean-miniroot:
	${EXEC_DIR}/runhooks hooks/miniroot clean

clean: clean-miniroot

.PHONY: miniroot
