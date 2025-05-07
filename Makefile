# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.26 2025/05/07 17:15:30 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

# Ragnarok is a custom Gentoo stage 4 archive, so start from stage 3.
# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot:
	@tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${DESTDIR}
	@for _dir in ${INCLUDES}; do \
		rsync -Klrv $$_dir/ ${DESTDIR}/; \
		done
	@scripts/genmount.sh ${DESTDIR}
	@scripts/mkrepo.sh ${SRCDIR} ${DESTDIR}

.PHONY: miniroot
