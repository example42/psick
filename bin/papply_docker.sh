#!/bin/bash
image=$1
PATH=$PATH:/opt/puppetlabs/bin

docker run -v /Users/al/Documents/github/EXAMPLE42/puppet-modules:/etc/puppetlabs/code/environments/production $1 /etc/puppetlabs/code/environments/production/bin/papply.sh --detailed-exitcodes 

if [ "x$?" == "x0" ] || [ "x$?" == "x1" ]; then
  exit 0
else
  exit 1
fi
