#!/bin/bash
echo '==> Starting clean up phase...'

echo '==> Cleaning up udev rules...'
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo '==> Cleaning up DHCP leases...'
if [ -d "/var/lib/dhcp" ]; then
    rm /var/lib/dhcp/*
fi

echo "==> Cleaning up tmp..."
rm -rf /tmp/*

echo '==> Cleaning up APT cache...'
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

echo '==> Cleaning deinstalled packages...'
dpkg --get-selections | grep -v deinstall

echo '==> Cleaning BASH history'
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

echo 'Cleaning up log files...'
find /var/log -type f | while read f; do echo -ne '' > $f; done;

echo 'Whiteout root...'
count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace

echo 'Whiteout /boot...'
count=$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count
rm /boot/whitespace

echo 'Zeroing free space to save space in the final image, this can take a while...'
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Sync with packer
sync