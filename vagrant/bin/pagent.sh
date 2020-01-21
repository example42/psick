#!/bin/bash
options=$*
PATH=$PATH:/opt/puppetlabs/puppet/bin

echo "## Running puppet agent -t ${options} --detailed-exitcodes"
puppet agent -t ${options} --detailed-exitcodes
result=$?
if [ "x$result" == "x0" ] || [ "x$result" == "x2" ]; then
  exit 0
else
  exit 1
fi
