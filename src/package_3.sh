#!/bin/bash

### every exit != 0 fails the script

export NO_VNC_HOME=/usr/libexec/noVNCdim
rm /headless/*.bz2*

git clone https://github.com/GH0STAV0/ALL_HCL.git
service tor restart

