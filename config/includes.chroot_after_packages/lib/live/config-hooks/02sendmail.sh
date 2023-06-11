#!/bin/sh

# Sending welcome mail with info to live user. This has to be done here because the
# default live user is created at boot.
/usr/bin/cat /var/messages/welcome.txt | mail -r LeCorbeau@ragnarok -s "Welcome" user
