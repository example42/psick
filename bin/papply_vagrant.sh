#!/bin/bash

if [ $1  ]; then
  manifest=$1
else
  manifest="/vagrant/manifests/site.pp"
fi

PATH=$PATH:/opt/puppetlabs/bin

echo "## Running Puppet version $(puppet --version) on ${manifest}"

puppet --version | grep "^4" > /dev/null
if [ "x$?" == "x0" ] ; then
  manifest_option=''
else
  manifest_option='--manifestdir /vagrant/manifests'
fi

puppet apply --verbose --report --show_diff --pluginsync --summarize --modulepath "/vagrant/modules_local:/vagrant/modules:/etc/puppet/modules" --hiera_config=/vagrant/hiera.yaml --detailed-exitcodes $manifest_option $manifest

if [ "x$?" == "x0" ] || [ "x$?" == "x1" ]; then
  exit 0
else
  exit 1
fi
