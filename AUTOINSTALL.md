# Automatic Installs

It is possible to install Ragnarok automatically (that is, without user
input) using a pre-made `install.conf` file and passing the `-a` option
to the installer:

In order to do so, simply create a custom `install.conf` file and save
it for later use.

## Creating install.conf

You can either create the file manually, or if booted in a live Ragnarok
system (or if the ragnarok-installer package is installed) run the mkconf
utility and answer all questions.

If you choose to run mkconf, still refer to the `users and passwords`
section near the end of this guide.

## Manual creation

With your preferred text editor, open a new file (to be saved as `install.conf`)
and fill in all answers, making sure there are no typographic errors (pay close
attention to capital letters).

Example file:

    Device = /dev/sda
    Bootmode = bios
    Swap = 8G
    Root = 35G
    Home = 
    Hostname = ragnarok
    Timezone = America/Montreal
    Locale = en_CA.UTF-8 UTF-8
    KB_Layout = ca
    KB_Variant = French (Canada)
    Sets = devel virt xserv xfonts xprogs

#### Notes:

`Bootmode`: this can be either `bios` or `efi`.

`Swap`, `Root` and `Home`: these are the size of each partitions. `Home`
may be left empty if you wish to use the remaining space on the device.
Always take into account that the installer will create a 500M boot partition
at install time.

`KB_Layout`: layout for the console and X11. A list of available layouts is
located at `/usr/share/ragnarok-installer/lists/xkblayout.list. First column
lists the layout, the second lists its variant.

`KB_Variant` can be determined by searching for your `KB_Layout` in the
xkblayout list using grep, e.g.

    $ grep "^ca" "/usr/share/ragnarok-installer/lists/xkblayout.list

`Sets`: metapackages containing extra software. These are optional. The
example file shows all available sets. You can pick and choose between
them, or install none at all, in which case you would use 'none':

    Sets = none

`Hostname`, `Timezone` and `Locale` are self-explanatory.

## Username and Passwords

The mkconf utility will not ask for username and passwords. At install
time, this is handled by the installer after its call to mkconf is done.

If you do not wish to be asked to set up passwords and username during an
automatic install, you may add them to install.conf. However, take note
that **storing passwords in plain text is not secure**. If you wish to
store your passwords in `install.conf`, you should only use temporary
passwords and change them as soon as you boot the system for the first
time.

To add them to the config file:

    Rootpass = your.temporary.rootpass
    Username = your.username
    Userpass = your.temporary.user.pass

## Using install.conf

To install Ragnarok automatically using a pre-made `install.conf` file
using the live ISO, ensure the file is present in the **same directory
you're running the installer from**, e.g. either the home directory of
the live user, or of the root user. Then launch the installer with the
`-a` option:

    # ragnarok-install -a
