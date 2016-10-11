#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

image=$2
role=$1
base_dir=$(pwd)
PATH=$PATH:/opt/puppetlabs/bin
echo_title "## Running Puppet apply on image example42/puppet-agent:${image} with role ${role} from ${base_dir}"
docker run -v "${base_dir}:/etc/puppetlabs/code/environments/production"  --name="${image}-${role}-$(date +'%H%M%S')" -e "FACTER_role=${role}" "example42/puppet-agent:${image}" bash -c /etc/puppetlabs/code/environments/production/bin/papply.sh --detailed-exitcodes 

if [ "x$?" == "x0" ] || [ "x$?" == "x1" ]; then
  exit 0
else
  exit 1
fi
