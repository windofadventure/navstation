#!/bin/bash -e

# https://github.com/dakk/gweatherrouting

apt-get -y install libeccodes0 libeccodes-tools libosmgpsmap-1.0-1 gir1.2-osmgpsmap-1.0
git clone -b gshhs2.3.6 https://github.com/dakk/gweatherrouting
cd gweatherrouting/
make install
cd ..
rm -rf gweatherrouting/

# Run using
# gweatherrouting
