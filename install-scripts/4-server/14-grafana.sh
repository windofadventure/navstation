#!/bin/bash -e

apt-get clean

apt-get -y -q install grafana=8.5.3

systemctl disable grafana-server

apt-get clean

