#!/bin/bash -e

pushd /usr/share/
  git clone https://github.com/victronenergy/venus-html5-app && cd venus-html5-app/
  pnpm install
  pnpm install caniuse-lite
  pnpm run build
popd

# to start:
#
# cd /usr/share/venus-html5-app
# pnpm run start
#
# And then open the app in the browser at http://localhost:8000
#
# This will start the webpack dev server, which will recompile the app on code changes and hot reload the UI.
#
# You can change the host and port (although the default 9001 is usually correct) query parameters to point to your Venus device:
#
# http://localhost:8000?host=<VENUS_DEVICE_IP>&port=9001
#
# This way you can run the local app against venus device data if the venus device is on the same network as your computer.

install -v -m 0644 $FILE_FOLDER/victron.service "/etc/systemd/system/"

systemctl disable victron.service

bash -c 'cat << EOF > /usr/local/share/applications/victron.desktop
[Desktop Entry]
Type=Application
Name=Victron
GenericName=Victron
Comment=Victron
Exec=gnome-www-browser http://localhost:8000
Terminal=false
Icon=help-browser
Categories=Utility;
EOF'

