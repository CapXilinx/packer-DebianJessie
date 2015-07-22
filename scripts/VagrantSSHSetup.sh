#!/bin/bash -x

VAGRANT_KEY_URL="https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub"
VAGRANT_USER="vagrant"

# Vagrant specific
date > /etc/vagrant_box_build_time

# Installing vagrant keys
mkdir -pm 700 /home/$VAGRANT_USER/.ssh
wget --no-check-certificate $VAGRANT_KEY_URL -O /home/$VAGRANT_USER/.ssh/authorized_keys
chmod 0600 /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER /home/$VAGRANT_USER/.ssh
