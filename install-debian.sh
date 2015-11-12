#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))

debootstrap --include linux-image-amd64,grub-pc jessie "$SCRIPT_DIR/mnt" 

chroot "$SCRIPT_DIR/mnt" passwd
chroot "$SCRIPT_DIR/mnt" adduser lape

echo "/dev/sda1 / ext4  errors=remount-ro 0 1" >> $SCRIPT_DIR/mnt/etc/fstab
