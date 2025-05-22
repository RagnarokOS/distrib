# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.34 2025/05/22 15:53:57 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

extract:
	@tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	@./runhooks hooks/miniroot extract

# Configure portage.
portage-config:
	@./chrootcmd ${DESTDIR} "emerge-webrsync"
	@./chrootcmd ${DESTDIR} "emerge -v app-eselect/eselect-repository dev-vcs/git"
	@./chrootcmd ${DESTDIR} "eselect repository disable gentoo" || true
	@./chrootcmd ${DESTDIR} "eselect repository enable gentoo" || true
	@rm -rf ${DESTDIR}/var/db/repos/gentoo
	@rsync -Klrv portage.conf/ ${DESTDIR}/
	@./chrootcmd ${DESTDIR} "emerge --sync"

# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot: extract portage-config
	@./runhooks hooks/miniroot setup
	@./chrootcmd ${DESTDIR} "emerge -avuDN --with-bdeps=y @world"

.PHONY: miniroot
