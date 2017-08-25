#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
# repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

RUBY=$(which ruby)
RAKE=$(which rake)
mods=${1:-site}
run=${2:-none}

global_exit=0

if [ ! -z ${RAKE} ] && [ ! -z ${RUBY} ] ; then
  echo_title "Running rspec tests on modules under ${mods} dir"
  for i in $(ls -1 "${repo_dir}/${mods}/")
  do
    echo_title "Running unit tests for $i"
    cd "${repo_dir}/${mods}/${i}"
    if [ "${run}" == "bundle" ]; then
      bundle
    fi
    rake spec
    if [ $? == 0 ]; then
      echo_success "OK"
    else
      echo_failure "ERROR"
      echo $err
      global_exit=1
    fi
  done
else
  echo_warning "rake not found."
fi

exit $global_exit
