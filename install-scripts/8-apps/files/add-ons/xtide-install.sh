#!/bin/bash -e

# See: https://flaterco.com/xtide/files.html

cd ~

sudo apt-get -y install libxaw7-dev libtcd-dev

wget https://flaterco.com/files/xtide/xtide-2.15.5.tar.xz
xzcat xtide-2.15.5.tar.xz | tar xvf -
cd xtide-2.15.5/
./configure
make -j 4
sudo make install
sudo ldconfig
cd ..
rm -rf xtide-2.15.5/


wget https://flaterco.com/files/xtide/wvs.tar.xz
xzcat wvs.tar.xz | tar xvf -
sudo mkdir /usr/share/wvs/
sudo mv wvs*.dat /usr/share/wvs/

sudo bash -c 'cat << EOF > /etc/xtide.conf
/usr/share/opencpn/tcdata/harmonics-dwf-20210110-free.tcd
/usr/share/wvs
EOF'

sudo bash -c 'cat << EOF > /usr/local/share/applications/xtide.desktop
[Desktop Entry]
Name=XTide
Exec=xtide
StartupNotify=true
Terminal=false
Type=Application
Icon=gnome-globe
Categories=Navigation
Keywords=Navigation
EOF'
