# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.27 2025/05/12 17:55:57 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

# Ragnarok is a custom Gentoo stage 4 archive, so start from stage 3.
# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot:
	@tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	@rsync -Klrv portage.conf/ ${DESTDIR}/
	@scripts/mkrepo.sh ${SRCDIR} ${DESTDIR}
	@rsync -Klrv portage.conf/ ${DESTDIR}/

.PHONY: miniroot
