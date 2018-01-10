#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
export PATH=/opt/puppetlabs/puppet/bin:$PATH
mods=${1:-site}
run=${2:-none}

global_exit=0

if [ "${mods}" != "controlrepo" ]; then
  echo_title "Running rspec tests on modules under ${mods} dir"
  for i in $(ls -1 "${repo_dir}/${mods}/")
  do
    echo_title "Running unit tests for $i"
    cd "${repo_dir}/${mods}/${i}"
    rm -f Gemfile.lock
    if [ "${run}" == "bundle" ]; then
      bundle --path=vendor
    fi
    bundle exec rake spec
    if [ $? == 0 ]; then
      echo_success "OK"
    else
      echo_failure "ERROR"
      global_exit=1
    fi
  done
else
  echo_title "Running control-repo rspec tests"
  if [ "${run}" == "bundle" ]; then
    bundle --path=vendor
  fi
  bundle exec rake spec
  if [ $? == 0 ]; then
    echo_success "OK"
  else
    echo_failure "ERROR"
    global_exit=1
  fi
fi

exit $global_exit
