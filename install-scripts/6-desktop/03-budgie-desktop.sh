#!/bin/bash -e

apt-get install -y -q libatk-adaptor libgtk-3-0 libatk1.0-0 libcairo2 libfontconfig1 libfreetype6 \
  libgdk-pixbuf2.0-0 libglib2.0-0  \
  libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 librsvg2-common libx11-6 menulibre \
  gvfs-fuse gvfs-backends gnome-bluetooth ibus

install -o 1000 -g 1000 -d /home/user/.config/openbox

## Start budgie-desktop boot.
install -o 1000 -g 1000 -m 644 -v $FILE_FOLDER/.xinitrc    "/home/user/"

echo '(chromium-browser --headless || true) &' >>/home/user/.config/openbox/autostart

apt-get clean

chmod 4775 /usr/bin/nm-connection-editor
#chmod 4775 /usr/bin/gnome-control-center

## Autostart openbox from budgie-desktop.
install -o 1000 -g 1000 -d /home/user/.config/autostart
install -o 1000 -g 1000 -m 644 -v $FILE_FOLDER/openbox.desktop    "/home/user/.config/autostart/"


# Budgie settings
gsettings set com.solus-project.budgie-wm focus-mode true
gsettings set com.solus-project.budgie-wm center-windows true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
