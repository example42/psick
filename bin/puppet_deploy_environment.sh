#!/bin/bash
script_dir="$(dirname $0)"
. "${script_dir}/functions"
environment=${1:-production}
PATH=/opt/puppetlabs/puppet/bin:$PATH

if [ -d "/etc/puppetlabs/code/environments/${environment}/.git" ]; then
  cd /etc/puppetlabs/code/environments/$environment
  git pull origin $environment
  r10k puppetfile install -v
else
  cd /etc/puppetlabs/code/environments/
  git clone $origin $environment
  r10k puppetfile install -v
fi
