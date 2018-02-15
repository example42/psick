#!/bin/bash

environment=${1:-"host"}
base_dir="/etc/puppetlabs/code/environments/${environment}"
manifest=${2:-"${base_dir}/manifests/site.pp"}

PATH=$PATH:/opt/puppetlabs/bin

echo "## Running Puppet apply on ${manifest}. Version $(puppet --version)"

puppet apply --test --report --summarize \
	--modulepath "${base_dir}/site:${base_dir}/modules:/etc/puppet/modules" \
	--environmentpath "${base_dir}/.." \
	--environment $environment \
	--detailed-exitcodes $manifest

result=$?
if [ "x$result" == "x0" ] || [ "x$result" == "x2" ]; then
  exit 0
else
  exit 1
fi

