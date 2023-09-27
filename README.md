iso
===

Release building infrastructure

Extra Info
==========

Building the iso (gist):

    # apt install --no-install-recommends -y live-build curl
    $ mkdir -p .local/build
    $ cd .local/build
    $ git clone https://github.com/RagnarokOS/iso.git
    $ git clone https://github.com/RagnarokOS/src.git
    $ git clone https://github.com/RagnarokOS/x11.git
    $ curl -OL https://github.com/RagnarokOS/kernel-build/releases/download/6.1.52/linux-image-6.1.52-ragnarok_6.1.52-ragnarok-1_amd64.deb
    $ cd iso
    $ make live-config
    # make iso

Note: answer 'Y' when asked to overwrite the motd file. This annoyance will
be fixed in due time.

Deprecated tools
----------------

The following scripts and files are deprecated: build.sh, mkiso and iso.conf.  
They will be removed when the Makefiles are complete.

