#!/bin/bash
repo_dir="$(dirname $0)/../"
manifest="${repo_dir}/manifests/site.pp"
extra_options=$*

PATH=$PATH:/opt/puppetlabs/puppet/bin

echo "## Running Puppet version $(puppet --version) on ${manifest}"
echo "## Role: ${FACTER_role} - $(facter -p role)" 
puppet --version | grep "^4" > /dev/null
if [ "x$?" == "x0" ] ; then
  manifest_option=''
else
  manifest_option="--manifestdir ${repo_dir}/manifests"
fi

puppet apply --verbose --report --show_diff --summarize \
	--modulepath "${repo_dir}/site:${repo_dir}/modules:/etc/puppetlabs/code//modules" \
	--environmentpath "${repo_dir}" \
	--hiera_config="${repo_dir}/hiera.yaml" \
	--config_version="/usr/bin/git --git-dir ${repo_dir}/.git log --pretty=format:\"%h - %an, %ad : %s\" -1" \
	--detailed-exitcodes $manifest_option $extra_options $manifest

if [ "x$?" == "x0" ] || [ "x$?" == "x1" ]; then
  exit 0
else
  exit 1
fi
