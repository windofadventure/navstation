#!/bin/bash -e

useradd -r -g solarthing -G dialout,tty,video solarthing
usermod -a -G dialout,tty,video solarthing
usermod -a -G gpio solarthing
usermod -a -G solarthing,dialout,tty,video user

curl https://raw.githubusercontent.com/wildmountainfarms/solarthing/master/other/linux/clone_install.sh | bash
/opt/solarthing/program/.bin/solarthing version || true
rm -rf ./*.core ./*.log
rm -rf /opt/solarthing/.git

