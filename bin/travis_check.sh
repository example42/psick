#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

global_exit=0

run_script() {
  status=${2:-'required'}
  $1
  if ([ $? = 0 ] || [ $status != 'required' ]); then
    echo_success "OK"
  else
    echo_failure "ERROR"
    global_exit=1
  fi
}

cd $repo_dir

# Syntax tests
run_script "bundle exec rake validate"
#run_script bin/puppet_check_syntax_fast.sh

# Lint tests
run_script "bundle exec rake lint" "optional"
#run_script bin/puppet_lint.sh optional

# Spec tests
if [ "x$SKIP_SPEC_TESTS" == 'xtrue' ]; then
  echo "Skipping spec tests"
else
  # Control repo nodes spec tests
  run_script "bundle exec rake spec"

  # Psick module spec tests
  cd "${repo_dir}/modules/psick" 
  run_script "bundle exec rake spec"

  # Public modules spec tests
  # run_script "bin/puppet_check_rake.sh modules"
fi

if [ $global_exit == 1 ]; then
  echo_failure "Some checks have failed"
else
  echo_success "All checks successfull!"
fi

exit $global_exit

