#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

results_dir="${repo_dir}/tests/vagrant/$(date +%Y%m%d-%H%M%S)"
mkdir -p $results_dir/failure
mkdir -p $results_dir/success

testing_branch=$(git name-rev --name-only HEAD)
current_branch='production'
global_exit=0
node=$1
env=$2

exit_manage() {
  error=$1
  file=$2
  if [ "x${error}" != "x0" ]; then
    mv $results_dir/$file $results_dir/failure
    global_exit=1
    echo_failure "Failed ($error)"
    echo "For details: $results_dir/failure/$file"
  else
    mv $results_dir/$file $results_dir/success
    echo_success "Success"
    echo "For details: $results_dir/success/$file"
    echo
  fi
}

run_vagrant() {
  echo_title "Running vagrant ${1} on node ${2} in env ${3} - Step ${4}"
  output_file="${2}_${3}-$(date +%H%M%S)-${1}-${4}"
  $repo_dir/vagrant/bin/vm.sh $1 $2 $3 > "${results_dir}/${output_file}" 2>&1
  exit_manage $? $output_file
}

# Testing sequence
run_vagrant up $node $env "1-setup"

git checkout $current_branch
run_vagrant provision $node $env "2-run-current"
# run_vagrant provision $node $env "2-current_bis"

git checkout $testing_branch
run_vagrant provision $node $env "3-run-testing"
# run_vagrant provision $node $env "4-testing_bis"

exit $global_exit

