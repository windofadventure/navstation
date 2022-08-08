#!/bin/bash -e

apt-get -y -q install empathy

apt-get clean

# FB messenger

if [ $LMARCH == 'armhf' ]; then
  arch=armv7l
elif [ $LMARCH == 'arm64' ]; then
  arch=arm64
  wget http://ftp.us.debian.org/debian/pool/main/libi/libindicator/libindicator3-7_0.5.0-4_arm64.deb
  wget http://ftp.mx.debian.org/debian/pool/main/liba/libappindicator/libappindicator3-1_0.4.92-7_arm64.deb
  dpkg -i libindicator3-7_0.5.0-4_arm64.deb libappindicator3-1_0.4.92-7_arm64.deb
  rm libindicator3-7_0.5.0-4_arm64.deb libappindicator3-1_0.4.92-7_arm64.deb
elif [ $LMARCH == 'amd64' ]; then
  arch=x64
else
  arch=$LMARCH
fi

wget https://github.com/mquevill/caprine/releases/download/v2.54.1-ARM/caprine_2.54.1_${arch}.deb

dpkg -i caprine_2.54.1_${arch}.deb

rm caprine_2.54.1_${arch}.deb
