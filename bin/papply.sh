#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

manifest="${repo_dir}/manifests/site.pp"
extra_options=$*

PATH=$PATH:/opt/puppetlabs/puppet/bin

echo_title "Running Puppet version $(puppet --version) on ${manifest}" 
echo_subtitle "Role: ${FACTER_role} - $(facter -p role)"  
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
  echo_success
  exit 0 
else
  echo_failure
  exit 1
fi
