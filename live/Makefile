# $Ragnarok: Makefile,v 1.1 2024/03/20 14:56:45 lecorbeau Exp $

MAKE	= make -C
SUBDIRS	= cli xserv

all: live-config

live-config:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir live-config; \
		done

iso:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir iso; \
		done
