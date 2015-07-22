#!/bin/bash -x

# Check if VirtualBox is used as virtualization environment
if [[ `facter virtual` != "virtualbox" ]]; then
    exit 0
fi

NEEDED_PACKAGES="bzip2 build-essential dkms linux-headers-$(uname -r)"

apt-get update
apt-get install -y $NEEDED_PACKAGES

mkdir -p /mnt/virtualbox
mount -o loop /home/vagrant/VBoxGuest*.iso /mnt/virtualbox
sh /mnt/virtualbox/VBoxLinuxAdditions.run
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
umount /mnt/virtualbox
rm -rf /home/vagrant/VBoxGuest*.iso
rm -rf /mnt/virtualbox

apt-get -y remove --purge $NEEDED_PACKAGES
apt-get autoremove -y