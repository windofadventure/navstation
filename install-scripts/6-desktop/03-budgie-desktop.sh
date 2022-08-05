#!/bin/bash -e

apt-get install -y -q libatk-adaptor libgtk-3-0 libatk1.0-0 libcairo2 libfontconfig1 libfreetype6 \
  libgdk-pixbuf2.0-0 libglib2.0-0  \
  libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 librsvg2-common libx11-6 menulibre \
  gvfs-fuse gvfs-backends gnome-bluetooth ibus #openbox

install -o 1000 -g 1000 -d /home/user/.config/openbox

## Start budgie-desktop on openbox boot.
install -o 1000 -g 1000 -m 644 -v $FILE_FOLDER/.xinitrc    "/home/user/"
#{
#  echo 'export XDG_CURRENT_DESKTOP=Budgie:GNOME'
#  echo 'budgie-desktop &'
#}  >>/home/user/.config/openbox/autostart

#echo '(chromium-browser --headless || true) &' >>/home/user/.config/openbox/autostart

apt-get clean

chmod 4775 /usr/bin/nm-connection-editor
#chmod 4775 /usr/bin/gnome-control-center
