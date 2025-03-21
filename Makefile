# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.24 2025/03/21 15:45:45 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

# Ragnarok is a custom Gentoo stage 4 archive, so start from stage 3.
# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot:
	tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	${MAKE} ${SRCDIR} miniroot
	scripts/genmount.sh ${DESTDIR}
	scripts/mkrepo.sh ${SRCDIR} ${DESTDIR}

.PHONY: miniroot
