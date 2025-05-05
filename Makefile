# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.25 2025/05/05 23:21:17 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

# Ragnarok is a custom Gentoo stage 4 archive, so start from stage 3.
# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot:
	tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	#${MAKE} ${SRCDIR} miniroot
	# It should be possible to build any custom stage4 archive with
	# this, not just Ragnarok's own releases, so re-think how we go
	# about taking files from 'src' and copy them to the unpacked
	# stage3.
	scripts/genmount.sh ${DESTDIR}
	scripts/mkrepo.sh ${SRCDIR} ${DESTDIR}

.PHONY: miniroot
