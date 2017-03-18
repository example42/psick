#!/bin/bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
role=$1
image=${2:-'*'}

PATH=$PATH:/opt/puppetlabs/bin
echo_title "## Running Puppet apply on image example42/puppet-agent:${image} with role ${role} from ${repo_dir}"
docker run -v "${repo_dir}:/etc/puppetlabs/code/environments/production"  --name="${image}-${role}-$(date +'%H%M%S')" -e "FACTER_role=${role}" "example42/puppet-agent:${image}" bash -c /etc/puppetlabs/code/environments/production/bin/papply.sh --detailed-exitcodes 

if [ "x$?" == "x0" ] || [ "x$?" == "x2" ]; then
  exit 0
else
  exit 1
fi
