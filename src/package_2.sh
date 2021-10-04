#!/bin/bash

### every exit != 0 fails the script
set -e
echo "Install Package - on  based ubuntu 20.04 LTS"
echo "Installing  dbus-x11 xauth xinit x11-xserver-utils xdg-utils"
#apt-get install -y dbus-x11 xauth xinit x11-xserver-utils xdg-utils--no-cache=true
DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing  supervisor pwgen openvpn autocutsel
