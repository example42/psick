#!/bin/bash

if [ -d /vagrant/manifests ]; then
  base_dir='/vagrant'
else
  base_dir='/etc/puppetlabs/code/environments/production'
fi

if [ $1  ]; then
  manifest=$1
else
  manifest="${base_dir}/manifests/site.pp"
fi

PATH=$PATH:/opt/puppetlabs/bin

echo "## Running Puppet apply on ${manifest}. Version $(puppet --version)"

puppet --version | grep "^4" > /dev/null
if [ "x$?" == "x0" ] ; then
  manifest_option=''
else
  manifest_option="--manifestdir ${base_dir}/manifests"
fi

puppet apply --verbose --report --show_diff --summarize \
	--modulepath "${base_dir}/site:${base_dir}/modules:/etc/puppet/modules" \
	--environmentpath $base_dir \
	--hiera_config "${base_dir}/hiera.yaml" \
	--detailed-exitcodes $manifest_option $manifest

if [ "x$?" == "x0" ] || [ "x$?" == "x1" ]; then
  exit 0
else
  exit 1
fi
