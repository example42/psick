#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
export PATH=/opt/puppetlabs/puppet/bin:$PATH

RUBY=$(which ruby)
mods=${1:-site}
role=${2:-none}

global_exit=0

if [ ! -z ${RUBY} ] ; then
  echo_title "Running bundle install"
  bundle install --with=integration --path=vendor
  for r in $(ls -1 spec/acceptance/ | grep _spec.rb | sed 's/_spec.rb//g') ; do
    echo_title "Running beaker for role ${r}"
    bundle exec rake beaker_roles:${r}
  done
  if [ $? == 0 ]; then
    echo_success "OK"
  else
    echo_failure "ERROR"
    echo $err
    global_exit=1
  fi
else
  echo_warning "rake not found."
fi

exit $global_exit
