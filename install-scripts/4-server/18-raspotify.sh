#!/bin/bash -e

if [ $LMARCH == 'armhf' ]; then
  #apt-get -y -q install raspotify=0.31.8~librespot.v0.3.1-54-gf4be9bb
  wget https://github.com/dtcooper/raspotify/blob/2d6ceca0921a632b73e45cb8dbed6b8a57b3b608/pool/main/r/raspotify/raspotify_0.31.8~librespot.v0.3.1-54-gf4be9bb_armhf.deb?raw=true -O rasp.deb
  dpkg -i rasp.deb && rm -f rasp.deb
  if ! grep -q raspotify /etc/group; then
  	groupadd raspotify
  fi
  usermod -a -G raspotify user
  systemctl disable raspotify
  install -d -m 755 -o 1000 -g 1000 "/home/user/.config/systemd/"
  install -d -m 755 -o 1000 -g 1000 "/home/user/.config/systemd/user/"
  install -v -m 644 -o 1000 -g 1000 $FILE_FOLDER/raspotify.service "/home/user/.config/systemd/user/raspotify.service"
fi

apt-get clean

pip3 install --upgrade spotify-cli

