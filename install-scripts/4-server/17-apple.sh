#!/bin/bash -e

apt-get -y -q install shairport-sync usbmuxd

install -v -m 0644 $FILE_FOLDER/shairport-sync.conf "/etc/"

usermod -aG gpio shairport-sync

systemctl enable shairport-sync

install -m 755 -d -o usbmux -g plugdev "/var/lib/usbmux"

apt-get clean
