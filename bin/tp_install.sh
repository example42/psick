#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
# repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

if [ $1 ]; then
  app=$1
else
  echo "You must specify a (valid) app name to install via tp"
  exit 1
fi

PATH=$PATH:/opt/puppetlabs/puppet/bin
echo_title "Running tp::install { ${app}: }. Puppet version $(puppet --version)"

# Run puppet apply with correct configs
puppet apply --verbose --report --show_diff --summarize \
	--modulepath "${repo_dir}/site:${repo_dir}/modules:/etc/puppetlabs/code/modules" \
	--environmentpath "${repo_dir}" \
	--hiera_config="${repo_dir}/hiera.yaml" \
	--detailed-exitcodes -e "tp::install { $app: auto_prereq => true }"


result=$?
# Puppet exit codes 0 and 2 both imply an error less run
if [ "x$result" == "x0" ] || [ "x$result" == "x2" ]; then
  echo_success "Puppet run without errors"
  exit 0
else
  echo_failure "There were errors in the Puppet run"
  exit 1
fi
