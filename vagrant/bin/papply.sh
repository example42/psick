#!/bin/bash
environment='host'
base_dir="/etc/puppetlabs/code/environments/${environment}"
manifest=${1:-"${base_dir}/manifests/site.pp"}

PATH=$PATH:/opt/puppetlabs/bin

echo "## Running Puppet apply on ${manifest}. Version $(puppet --version)"

puppet --version | grep "^4" > /dev/null
if [ "x$?" == "x0" ] ; then
  manifest_option=''
else
  manifest_option="--manifestdir ${base_dir}/manifests"
fi

puppet apply --test --report --summarize \
	--modulepath "${base_dir}/site:${base_dir}/modules:/etc/puppet/modules" \
	--environmentpath "${base_dir}/.." \
	--environment $environment \
	--hiera_config "${base_dir}/bin/hiera3.yaml" \
	--detailed-exitcodes $manifest_option $manifest

result=$?
if [ "x$result" == "x0" ] || [ "x$result" == "x2" ]; then
  exit 0
else
  exit 1
fi

