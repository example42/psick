#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
# repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

PUPPET=$(which puppet)
ERB=$(which erb)
RUBY=$(which ruby)
RAKE=$(which rake)
mods=${1:site}

global_exit=0

if [ ! -z ${RAKE} ] && [ ! -z ${RUBY} ] ; then
  echo_title "Running rspec tests on modules under ${mods} dir"
  for i in $(ls -1 "${repo_dir}/${mods}/")
  do
    echo -ne "$i - "
    cd "${repo_dir}/${mods}/${i}"
    rake spec
    if [ $? = 0 ]; then
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
