# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.38 2025/05/27 15:55:50 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

extract:
	@tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	@./runhooks hooks/miniroot extract

# Configure portage.
portage-config:
	@./chrootcmd ${DESTDIR}/miniroot "emerge-webrsync"
	@./chrootcmd ${DESTDIR}/miniroot "emerge -v app-eselect/eselect-repository dev-vcs/git"
	@./chrootcmd ${DESTDIR}/miniroot "eselect repository disable gentoo" || true
	@./chrootcmd ${DESTDIR}/miniroot "eselect repository enable gentoo" || true
	@rm -rf ${DESTDIR}/miniroot/var/db/repos/gentoo
	@rsync -Klrv portage.conf/ ${DESTDIR}/miniroot/
	@./chrootcmd ${DESTDIR}/miniroot "emerge --sync"

# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot: extract portage-config
	@./runhooks hooks/miniroot setup
	@./chrootcmd ${DESTDIR}/miniroot "emerge -avuDN --with-bdeps=y @world"
	@./mktar miniroot

clean-miniroot:
	@./runhooks hooks/miniroot clean

clean: clean-miniroot

.PHONY: miniroot
