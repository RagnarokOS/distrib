# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.32 2025/05/21 16:23:27 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

# Configure portage.
# Make sure eselect-repository returns true even if portage reports that
# the gentoo repo wasn't enabled or is already enabled.
portage-config:
	@./chrootcmd ${DESTDIR} "emerge-webrsync"
	@./chrootcmd ${DESTDIR} "emerge -v app-eselect/eselect-repository dev-vcs/git"
	@./chrootcmd ${DESTDIR} "eselect repository disable gentoo" || true
	@./chrootcmd ${DESTDIR} "eselect repository enable gentoo" || true
	@rm -rf ${DESTDIR}/var/db/repos/gentoo
	@rsync -Klrv portage.conf/ ${DESTDIR}/
	@./chrootcmd ${DESTDIR} "emerge --sync"

# Ragnarok is a custom Gentoo stage 4 archive, so start from stage 3.
# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot:
	@tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	@./runhooks hooks/miniroot extract
	@./runhooks hooks/miniroot setup

.PHONY: miniroot
