#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

env=$1
maxrun=${2:-6}
sleeptime=${3:-10}
numrun=1
echo_title "Display of /etc/puppetlabs/code/environments/$env/.r10k-deploy.json"
sudo cat /etc/puppetlabs/code/environments/$env/.r10k-deploy.json 2>/dev/null
echo_title "Deployment status on ${env} - doing maximum ${maxrun} try every ${sleeptime} sec."
while [ $numrun -le $maxrun ]; 
do
	echo_title "Running check ${numrun}/${maxrun}"
	deployed_commit=$(sudo cat /etc/puppetlabs/code/environments/$env/.r10k-deploy.json | grep signature | awk '{ print $2}' | sed -e 's/"//g'  | sed -e 's/,//')
	local_commit=$(git rev-parse HEAD)
	echo_title "Deployed commit on Puppet Server: ${deployed_commit}"
	git show --no-abbrev-commit -s ${deployed_commit}
	echo_title "Latest commit on local runner repo: ${local_commit}"
	git show --no-abbrev-commit -s ${local_commit}

	echo_title "----------------------------------------------------------------------------------"
	if [[ "${deployed_commit}" == "${local_commit}" ]]; then
  		echo_success "Code correctly deployed to Puppet Server"
		exit 0
	fi
	sleep $sleeptime
	(( numrun ++ ))
done
echo_failure "Code not correctly deployed to Puppet Server !!!"
exit 1
