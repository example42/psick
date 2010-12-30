#!/bin/sh
lock="/var/lib/puppet/.pdcsetup.lock"
[ -f $lock ] && exit 0
touch $lock

net groupmap modify ntgroup="Domain Admins" unixgroup=admins
net groupmap modify ntgroup="Domain Users" unixgroup=users
net groupmap modify ntgroup="Domain Guests" unixgroup=nobody
useradd -d /dev/null -g machines -s /bin/false -M $(hostname -s)$
passwd -l $(hostname -s)$
