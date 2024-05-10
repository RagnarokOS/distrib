# $Ragnarok: Makefile,v 1.3 2024/05/10 15:43:55 lecorbeau Exp $

MAKE	= make -C
SUBDIRS	= live install

all: live-config

live-config:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir live-config; \
		done

iso:
	for _dir in ${SUBDIRS}; do \
		${MAKE} $$_dir iso; \
		done
