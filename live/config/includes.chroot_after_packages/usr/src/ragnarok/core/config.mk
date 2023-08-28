PREFIX = /usr
MANPREFIX = $(PREFIX)/share/man

CC      = cc
LD      = $(CC)

HARDENING_CFLAGS = -D_FORTIFY_SOURCE=2 -fPIE -Wformat-security -fstack-protector-strong -fstack-clash-protection --param=ssp-buffer-size=4 -fcf-protection
HARDENING_LDFLAGS = -Wl,-z,relro,-z,now -Wl,-pie

CFLAGS  = -std=c99 -pedantic -Wall -Os ${HARDENING_CFLAGS} -I/usr/X11R6/include
LDFLAGS = -lxcb -lxcb-util -lxcb-cursor ${HARDENING_LDFLAGS}  -L/usr/X11R6/lib

