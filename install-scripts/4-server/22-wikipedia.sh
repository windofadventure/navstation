#!/bin/bash -e

apt-get install -y liblzma libicu libzstd libxapian libcurl4-gnutls

if [ $LMARCH == 'arm64' ]; then
  wget https://github.com/bareboat-necessities/lysmarine_gen/releases/download/vTest/libzim7_7.2.0.0_arm64.deb
  wget https://github.com/bareboat-necessities/lysmarine_gen/releases/download/vTest/libkiwix10_0.0.0_arm64.deb
  wget https://github.com/bareboat-necessities/lysmarine_gen/releases/download/vTest/kiwix-tools_0.0.0_arm64.deb
  dpkg -i libzim7_*.deb libkiwix10_*.deb kiwix-tools_*.deb
  rm libzim7_*.deb libkiwix10_*.deb kiwix-tools_*.deb
fi
