# iso-specific config file

PUBLISHER	= Ian LeCorbeau
ISO_MODE	= live
HDD_LABEL	= RAGNAROK
X11_BOOTPARAMS	= boot=live live-config.hooks=filesystem live-config.locales=en_CA.UTF-8 \
		  live-config.timezone=Canada/Eastern live-config.hostname=ragnarok \
		  live-config.noautologin live-config.sysv-rc=openntpd slab_nomerge \
		  init_on_alloc=1 init_on_free=1 page_alloc.shuffle=1 pti=on \
		  randomize_kstack_offset=on vsyscall=none debugfs=off \
		  lockdown=confidentiality
CLI_BOOTPARAMS	= boot=live live-getty console=ttyS0,115200n8 live-config.hooks=filesystem \
		  live-config.locales=en_CA.UTF-8 live-config.timezone=Canada/Eastern \
		  live-config.hostname=ragnarok live-config.noautologin live-config.sysv-rc=openntpd \
		  slab_nomerge init_on_alloc=1 init_on_free=1 page_alloc.shuffle=1 pti=on \
		  randomize_kstack_offset=on vsyscall=none debugfs=off lockdown=confidentiality
