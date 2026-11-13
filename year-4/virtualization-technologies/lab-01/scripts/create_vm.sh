#!/bin/bash
set -e

VBOX="/Applications/VirtualBox.app/Contents/MacOS/VBoxManage"
VM="WS_VIN_bridge_test"
DISK="$HOME/VirtualBox VMs/$VM/disk.vdi"

"$VBOX" createvm --name "$VM" --platform-architecture arm --register

"$VBOX" modifyvm "$VM" \
    --memory 4096 \
    --cpus 2 \
    --firmware efi \
    --nic1 bridged \
    --bridgeadapter1 "en0: Wi-Fi" \
    --nictype1 virtio

"$VBOX" createmedium disk --filename "$DISK" --size 20480

"$VBOX" storagectl "$VM" --name "VirtIO SCSI" --add virtio-scsi --controller VirtIO

"$VBOX" storageattach "$VM" \
    --storagectl "VirtIO SCSI" \
    --port 0 --device 0 --type hdd --medium "$DISK"

"$VBOX" showvminfo "$VM"

