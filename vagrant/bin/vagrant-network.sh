#!/bin/bash

echo "### Workaround for https://github.com/mitchellh/vagrant/issues/8166"
if [ -f /sbin/ifconfig ]; then
  /sbin/ifconfig eth1 && restart=yes
else
 ip a | grep eth1 && restart=yes
fi

if [ "x$restart" == "xyes" ]; then
  sudo ifup eth1 2>/dev/null
fi
