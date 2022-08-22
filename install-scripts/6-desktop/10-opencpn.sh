#!/bin/bash -e

#apt-get install -y -q -o Dpkg::Options::="--force-overwrite" opencpn-sglock-arm32

#apt-get install -y -q opencpn opencpn-plugin-celestial opencpn-plugin-launcher opencpn-plugin-radar \
#   opencpn-plugin-pypilot opencpn-plugin-objsearch opencpn-plugin-iacfleet imgkap

apt-get install -y -q opencpn gettext

install -o 1000 -g 1000 -d "/home/user/.opencpn"
install -o 1000 -g 1000 -v $FILE_FOLDER/opencpn.conf "/home/user/.opencpn/"
install -o 1000 -g 1000 -v $FILE_FOLDER/opencpn.conf "/home/user/.opencpn/opencpn.conf-bbn"
install -o 1000 -g 1000 -v $FILE_FOLDER/opencpn.conf-highres-bbn "/home/user/.opencpn/opencpn.conf-highres-bbn"

if [ $LMARCH == 'armhf' ]; then
  apt-get install -y -q                                         \
    opencpn-doc                                                 \
    opencpn-plugin-calculator                                   \
    opencpn-plugin-celestial                                    \
    opencpn-plugin-chartscale                                   \
    opencpn-plugin-climatology                                  \
    opencpn-plugin-climatology-data                             \
    opencpn-plugin-iacfleet                                     \
    opencpn-plugin-launcher                                     \
    opencpn-plugin-nmeaconverter                                \
    opencpn-plugin-objsearch                                    \
    opencpn-plugin-ocpndebugger                                 \
    opencpn-plugin-plots                                        \
    opencpn-plugin-pypilot                                      \
    opencpn-plugin-radar                                        \
    opencpn-plugin-s63                                          \
    opencpn-plugin-sar                                          \
    opencpn-plugin-tactics                                      \
    opencpn-plugin-vfkaps                                       \
    opencpn-plugin-watchdog                                     \
    opencpn-plugin-weatherfax                                   \
    opencpn-plugin-weatherrouting                               \
    opencpn-plugin-draw
fi

# Polar Diagrams

BK_DIR="$(pwd)"

mkdir /home/user/Polars && cd /home/user/Polars

wget https://www.seapilot.com/wp-content/uploads/2018/05/All_polar_files.zip
unzip All_polar_files.zip
chown user:user ./*
chmod 664 ./*
rm All_polar_files.zip

cd "$BK_DIR"


wget https://launchpad.net/~opencpn/+archive/ubuntu/opencpn/+files/opencpn-doc_4.8.2.0-0~bionic1_all.deb
dpkg -i opencpn-doc_4.8.2.0-0~bionic1_all.deb
rm opencpn-doc_4.8.2.0-0~bionic1_all.deb

mkdir tmp-o-bundle-$LMARCH || exit 2
cd tmp-o-bundle-$LMARCH

wget -O opencpn-plugins-bundle-o_5_6_x-$LMARCH.tar.gz https://github.com/bareboat-necessities/opencpn-plugins-bundle/raw/main/bundles/opencpn-plugins-bundle-o_5_6_x-bullseye-$LMARCH.tar.gz?raw=true
gzip -cd opencpn-plugins-bundle-o_5_6_x-$LMARCH.tar.gz | tar xvf -

cp -r -p lib/* /usr/lib/
cp -r -p bin/* /usr/bin/
cp -r -p share/* /usr/share/
cp -r -p doc/* /usr/doc/
cp -r -p include/* /usr/include/

cd ..
rm -rf tmp-o-bundle-$LMARCH

if [ $LMARCH == 'arm64' ]; then
  mkdir tmp-op && cd tmp-op
  wget https://github.com/bareboat-necessities/opencpn-plugins-bundle/raw/main/rtlsdr_pi/bullseye-arm64/librtlsdr_pi.so && \
  mv librtlsdr_pi.so /usr/lib/opencpn/

  wget https://github.com/bareboat-necessities/opencpn-plugins-bundle/raw/main/launcher_pi/bullseye-arm64/liblauncher_pi.so && \
  mv liblauncher_pi.so /usr/lib/opencpn/
  mkdir -p /usr/share/opencpn/plugins/launcher_pi/data
  wget -O /usr/share/opencpn/plugins/launcher_pi/data/launcher_pi.svg https://github.com/nohal/launcher_pi/raw/master/data/launcher_pi.svg
  wget -O /usr/share/opencpn/plugins/launcher_pi/data/launcher_pi_rollover.svg https://github.com/nohal/launcher_pi/raw/master/data/launcher_pi_rollover.svg
  wget -O /usr/share/opencpn/plugins/launcher_pi/data/launcher_pi_toggled.svg https://github.com/nohal/launcher_pi/raw/master/data/launcher_pi_toggled.svg

  wget https://github.com/bareboat-necessities/opencpn-plugins-bundle/raw/main/ocpndebugger_pi/bullseye-arm64/libocpndebugger_pi.so && \
  mv libocpndebugger_pi.so /usr/lib/opencpn/
  mkdir -p /usr/share/opencpn/plugins/ocpndebugger_pi/data
  wget -O /usr/share/opencpn/plugins/ocpndebugger_pi/data/ocpndebugger_pi.svg https://github.com/nohal/ocpndebugger_pi/raw/master/data/ocpndebugger_pi.svg
  wget -O /usr/share/opencpn/plugins/ocpndebugger_pi/data/ocpndebugger_pi_rollover.svg https://github.com/nohal/ocpndebugger_pi/raw/master/data/ocpndebugger_pi_rollover.svg
  wget -O /usr/share/opencpn/plugins/ocpndebugger_pi/data/ocpndebugger_pi_toggled.svg https://github.com/nohal/ocpndebugger_pi/raw/master/data/ocpndebugger_pi_toggled.svg

  wget https://github.com/bareboat-necessities/opencpn-plugins-bundle/raw/main/objsearch_pi/bullseye-arm64/libobjsearch_pi.so && \
  mv libobjsearch_pi.so /usr/lib/opencpn/
  mkdir -p /usr/share/opencpn/plugins/objsearch_pi/data
  wget -O /usr/share/opencpn/plugins/objsearch_pi/data/objsearch_pi.svg https://github.com/nohal/objsearch_pi/raw/master/data/objsearch_pi.svg
  wget -O /usr/share/opencpn/plugins/objsearch_pi/data/objsearch_pi_rollover.svg https://github.com/nohal/objsearch_pi/raw/master/data/objsearch_pi_rollover.svg
  wget -O /usr/share/opencpn/plugins/objsearch_pi/data/objsearch_pi_toggled.svg https://github.com/nohal/objsearch_pi/raw/master/data/objsearch_pi_toggled.svg

  wget https://github.com/bareboat-necessities/opencpn-plugins-bundle/raw/main/iacfleet_pi/bullseye-arm64/IACFleet-0.30.0%2B2208221341.badb38c_debian-11-arm64.tar.gz
  gzip -cd IACFleet-0.30.0+2208221341.badb38c_debian-11-arm64.tar.gz | tar xvf - --strip-components=1
  cp -r -p lib/* /usr/lib/
  cp -r -p share/* /usr/share/
  mv /usr/share/opencpn/plugins/IACFleet_pi /usr/share/opencpn/plugins/iacfleet_pi

  wget https://dl.cloudsmith.io/public/opencpn/windvane-prod/raw/names/windvane_pi-1.0.26.0-flatpak-aarch64-20.08-flatpak-arm64-tarball/versions/v1.0.26.0/windvane_pi-1.0.26.0-aarch64_flatpak-20.08.tar.gz
  gzip -cd windvane_pi-1.0.26.0-aarch64_flatpak-20.08.tar.gz | tar xvf - --strip-components=1
  cp -r -p lib/* /usr/lib/
  cp -r -p share/* /usr/share/

  cd .. && rm -rf tmp-op
fi


if [ -f /usr/lib/opencpn/libPolar_pi.so ]; then
  mv /usr/lib/opencpn/libPolar_pi.so /usr/lib/opencpn/libpolar_pi.so
fi

if [ -f /usr/lib/opencpn/liblogbookkonni_pi.so ]; then
  rm -f /usr/lib/opencpn/libLogbookKonni_pi.so
fi

mv /usr/share/opencpn/plugins/tactics_pi/data/Tactics.svg /usr/share/opencpn/plugins/tactics_pi/data/tactics.svg
mv /usr/share/opencpn/plugins/tactics_pi/data/Tactics_rollover.svg /usr/share/opencpn/plugins/tactics_pi/data/tactics_rollover.svg
mv /usr/share/opencpn/plugins/tactics_pi/data/Tactics_toggled.svg /usr/share/opencpn/plugins/tactics_pi/data/tactics_toggled.svg
