# $Ragnarok: Makefile,v 1.2 2024/05/08 15:18:54 lecorbeau Exp $

MAKE	= make -C
SUBDIRS	= cli full

all: live-config

live-config:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir live-config; \
		done

iso:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir iso; \
		done
