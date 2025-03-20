# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.23 2025/03/20 23:31:20 lecorbeau Exp $
#
# Work in progress

include config.mk

# Ragnarok is a custom Gentoo stage 4 archive, so start from stage 3.
# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot:
	tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	${MAKE} ${SRCDIR} miniroot

.PHONY: miniroot
