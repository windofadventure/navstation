#!/bin/bash -e


wget https://flaterco.com/files/xtide/harmonics-dwf-20220109-free.tar.xz
xzcat harmonics-dwf-20220109-free.tar.xz | tar xvf  -
rm harmonics-dwf-20220109-free.tar.xz
sudo cp -r harmonics-dwf-20220109 /usr/share/opencpn/tcdata/
rm -rf harmonics-dwf-20220109/

