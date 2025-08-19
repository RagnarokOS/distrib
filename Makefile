# Build Gentoo pkg for distrib.
# $Ragnarok$

PKG		= ragnarok-dist
VERSION		= 0.1
PREFIX		= usr/
LIBDIR		= ${PREFIX}lib
MANPREFIX	= ${PREFIX}share/man
DIRS		= ${PREFIX}share/${PKG} \
		  ${LIBDIR}/${PKG} \
		  ${MANPREFIX}/man1 \
		  ${MANPREFIX}/man5
EXAMPLES	= miniroot base
SCRIPTS		= scripts/genmount.sh scripts/checkdep.sh

dirs:
	for _dir in ${DIRS}; do \
		install -d ${DESTDIR}/$$_dir; \
		done

install: dirs
	cp -r ${EXAMPLES} ${DESTDIR}${PREFIX}share/${PKG}/
	for _script in ${SCRIPTS}; do \
		install -m 755 $$_script ${DESTDIR}${LIBDIR}/${PKG}; \
		done
