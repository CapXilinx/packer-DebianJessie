#!/bin/bash

# Check if VirtualBox is used as virtualization environment
if [[ `facter virtual` != "virtualbox" ]]; then
    exit 0
fi

mkdir -p /mnt/virtualbox
mount -o loop /home/vagrant/VBoxGuest*.iso /mnt/virtualbox
sh /mnt/virtualbox/VBoxLinuxAdditions.run
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
umount /mnt/virtualbox
rm -rf /home/vagrant/VBoxGuest*.iso
rm -rf /mnt/virtualbox