#!/bin/sh
## Executed once when uppet runs
## Installs the packages required for installing Oracle applications
## If you want to rerun it, remove the "lock" file 


lock="/var/lib/puppet/.install_oracle_dependency.lock"
[ -f $lock ] && exit 0
touch $lock


yum -y install binutils control-center glibc glibc-common glibc-devel gnome-libs make pdksh xscreensaver xorg-x11 libaio xorg-x11-deprecated-libs openmotif21 java-1.4.2-ibm TIVsm-API64 redhat-lsb

yum -y install libstdc++.i386 libstdc++-devel.i386 compat-libstdc++-33.i386 compat-libstdc++-296.i386 compat-db.i386

yum -y install libstdc++.x86_64 gcc-c++.x86_64 libstdc++-devel.x86_64 compat-libstdc++-33.x86_64 compat-libstdc++-296.x86_64 compat-db.x86_64 glibc-devel.i386
