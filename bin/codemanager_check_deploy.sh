#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

env=$1

echo_title "Deployment status on ${env}"
sudo cat /etc/puppetlabs/code/environments/$env/.r10k-deploy.json

deployed_commit=$(sudo /usr/bin/cat /etc/puppetlabs/code/environments/$env/.r10k-deploy.json | grep signature | awk '{ print $2}' | sed -e 's/"//g'  | sed -e 's/,//')
echo_title "Deployed commit on Puppet Server: ${deployed_commit}"
git show --no-abbrev-commit -s ${deployed_commit}

local_commit=$(git rev-parse HEAD)
echo_title "Latest commit on local runner repo: ${local_commit}"
git show --no-abbrev-commit -s ${local_commit}

if [[ "${deployed_commit}" == "${local_commit}" ]]; then
  echo_success "Code correctly deployed to Puppet Server"
  exit 0 
else
  echo_failure "Code not correctly deployed to Puppet Server !!!"
  exit 1 
fi
