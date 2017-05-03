#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

global_exit=0

run_script() {
  $1
  if ([ $? = 0 ] || [ $2 != 'required' ]); then
    echo_success "OK"
  else
    echo_failure "ERROR"
    global_exit=1
  fi
}

run_script bin/puppet_check_syntax_fast.sh
run_script bin/puppet_lint.sh optional
run_script "bin/puppet_check_rake.sh site bundle"

exit $global_exit
