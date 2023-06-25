rt - a simple terminal
====================

rt is a simple terminal for X, forked from Suckless' [st](https://st.suckless.org/).
It is primarily designed to provide a light and minimal terminal for [tmux](https://github.com/tmux/tmux/wiki).

Requirements
------------

In order to build rt you need the Xlib header files.


Installation
------------

__Debian-based systems__: it is recommended to build rt as a deb
package. With the devscripts package installed, run the following commands
inside rt's directory:

```
# mk-build-deps --install debian/control
$ debuild -i -us -uc -b
```

apt can then be used to install the package by pointing to its location:

```
apt-get install /full/path/to/rt-package.deb
```

Updating the package can be done by running _git pull_ in the rt
directory and repeating the steps above.

__Non-Debian systems__: edit config.mk to match your local setup (rt
is installed into the /usr/bin namespace by default).

Afterwards enter the following command to build and install (if
necessary as root):

```
make clean install
```

Running rt
----------
If you did not install rt with a deb package or make clean install,
you must compile the rt terminfo entry with the following command:

    tic -sx rt.info

See the man page for additional details.

Credits
-------
Based on Suckless' simple terminal, which itself is based on
Aurélien APTEL <aurelien dot aptel at gmail dot com> bt source code.

