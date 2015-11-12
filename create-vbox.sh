#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
source "$SCRIPT_DIR/vbox.conf" 

VBoxManage createvm --name "$VM_NAME" --register
VBoxManage modifyvm "$VM_NAME" --memory 4096 --acpi on 
VBoxManage modifyvm "$VM_NAME" --nic1 bridged --bridgeadapter1 eth0
VBoxManage modifyvm "$VM_NAME" --macaddress1 123456789012
VBoxManage modifyvm "$VM_NAME" --ostype Debian

VBoxManage createhd --filename "$HDD_IMAGE" --size 5000
VBoxManage storagectl    "$VM_NAME" --name       "IDE Controller" --add ide
VBoxManage storageattach "$VM_NAME" --storagectl "IDE Controller"  \
    --port 0 --device 0 --type hdd --medium "$HDD_IMAGE" 
