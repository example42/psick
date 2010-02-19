#!/bin/sh
## Installs the packages required for installing Oracle applications

yum install -y binutils compat-db compat-libstdc++ control-center gcc gcc-c++ glibc glibc-common gnome-libs libstdc++ libstdc++-devel make pdksh sysstat xscreensaver setarch libXp libXtst.i386
yum groupinstall -y "X Window System"

