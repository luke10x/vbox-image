#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root" 1>&2
    exit 1
fi

SCRIPT_DIR=$(dirname $(readlink -f $0))
source "$SCRIPT_DIR/vbox.conf" 

rmmod nbd
modprobe nbd max_part=16
qemu-nbd -c /dev/nbd0 "$HDD_IMAGE"

printf "n\np\n1\n\n\na\n1\nw\n" | fdisk /dev/nbd0

mkfs.ext4 /dev/nbd0p1
mkdir "$SCRIPT_DIR/mnt"
mount /dev/nbd0p1 "$SCRIPT_DIR/mnt" 

grub2-install /dev/nbd0
