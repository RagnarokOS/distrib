# rt - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = rt.c x.c
OBJ = $(SRC:.c=.o)

all: options rt

options:
	@echo rt build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

rt.o: config.h rt.h win.h
x.o: arg.h config.h rt.h win.h

$(OBJ): config.h config.mk

rt: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f rt $(OBJ) rt-$(VERSION).tar.gz

dist: clean
	mkdir -p rt-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README.md config.mk\
		config.def.h rt.info rt.1 rt.xresources arg.h rt.h win.h $(SRC)\
		rt-$(VERSION)
	tar -cf - rt-$(VERSION) | gzip > rt-$(VERSION).tar.gz
	rm -rf rt-$(VERSION)

install: rt
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f rt $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/rt
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f rt.1 $(DESTDIR)$(MANPREFIX)/man1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/rt.1
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/rt-term
	cp -f rt.xresources $(DESTDIR)$(PREFIX)/share/doc/rt-term
	chmod 644 $(DESTDIR)$(PREFIX)/share/doc/rt-term/rt.xresources
	tic -sx rt.info
	@echo Please see the README.md file regarding the terminfo entry of rt.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/rt
	rm -f $(DESTDIR)$(MANPREFIX)/man1/rt.1

.PHONY: all options clean dist install uninstall
