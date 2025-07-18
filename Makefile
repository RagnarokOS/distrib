# Makefile for creating Ragnarok releases.
# $Ragnarok: Makefile,v 1.50 2025/07/18 16:14:36 lecorbeau Exp $
#
# Work in progress

include config.mk

MAKE	= make -C

depends:
	./checkdep

extract:
	mkdir ${MINIROOT}
	tar xpvf ${TARBALL} --xattrs-include='*.*' --numeric-owner -C ${MINIROOT}
	./runhooks hooks/miniroot extract

# Configure portage.
portage-config:
	./chrootcmd ${MINIROOT} "emerge-webrsync"
	./chrootcmd ${MINIROOT} "emerge -v app-eselect/eselect-repository dev-vcs/git"
	./chrootcmd ${MINIROOT} "eselect repository disable gentoo" || true
	./chrootcmd ${MINIROOT} "eselect repository enable gentoo" || true
	rm -rf ${MINIROOT}/var/db/repos/gentoo
	rsync -Klrv portage.conf/ ${MINIROOT}/
	./chrootcmd ${MINIROOT} "emerge --sync"

# TODO: lots of stuff, but especially, don't forget to cleanup before
# creating stage 4.
miniroot: depends extract portage-config
	./runhooks hooks/miniroot setup
	./chrootcmd ${MINIROOT} "emerge -avuDN --with-bdeps=y @world"
	./runhooks hooks/miniroot clean
	./mktar miniroot

# Base is built using miniroot
base:
	mkdir ${BASE}
	tar xpvf miniroot${VERSION}.tgz --xattrs-include='*.*' --numeric-owner -C ${BASE}
	rsync -Klrv includes.preinst/ ${BASE}/ || true
	./runhooks hooks/base configure
	./chrootcmd ${BASE} "emerge -v sys-apps/ragnarok-base"
	rsync -Klrv includes.postinst/ ${BASE} || true

release: miniroot base

clean-miniroot:
	./runhooks hooks/miniroot clean

clean: clean-miniroot

.PHONY: miniroot
