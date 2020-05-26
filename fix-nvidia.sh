#!/usr/bin/env bash

sudo service gdm stop

sudo wget http://us.download.nvidia.com/XFree86/Linux-x86_64/440.82/NVIDIA-Linux-x86_64-440.82.run -O nivida-linux.run

sudo service gdm start
