#!/bin/bash

PATH=$PATH:/opt/puppetlabs/bin

echo "## Running Puppet version $(puppet --version) on ${manifest}"

docker run -v .:/docker $1 puppet apply --verbose --report --show_diff --pluginsync --summarize --modulepath "/docker/site:/docker/modules:/etc/puppet/modules" --hiera_config=/docker/hiera.yaml --detailed-exitcodes $manifest_option $manifest

if [ "x$?" == "x0" ] || [ "x$?" == "x1" ]; then
  exit 0
else
  exit 1
fi
