# $Ragnarok: Makefile,v 1.4 2024/05/14 16:29:34 lecorbeau Exp $

MAKE	= make -C
SUBDIRS	= live

all: live-config

live-config:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir live-config; \
		done

iso:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir iso; \
		done
