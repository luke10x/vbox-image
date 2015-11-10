#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root" 1>&2
    exit 1
fi

SCRIPT_DIR=$(dirname $(readlink -f $0))
source "$SCRIPT_DIR/vbox.conf" 

umount "$SCRIPT_DIR/mnt"
rm -fr "$SCRIPT_DIR/mnt"
qemu-nbd -d /dev/nbd0
