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
action=${3:-all}
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
  
  $repo_dir/vagrant/bin/vm.sh "$1" "$2" "$3" | tee "${results_dir}/${output_file}" 
  exit_manage $PIPESTATUS $output_file
}

# Testing sequence
if [ $action == 'destroy' ]; then
  run_vagrant "destroy -f" $node $env "0-destroy"
elif [ $action == 'halt' ]; then
  run_vagrant "halt -f" $node $env "0-halt"
else 
  if [ $action == 'setup' ] || [ $action == 'all' ]; then
    git checkout -f $current_branch
    git pull
    run_vagrant up $node $env "1-setup"
    run_vagrant provision $node $env "2-run-current"
  fi

  if [ $action == 'drift' ] || [ $action == 'all' ]; then
    git checkout -f $testing_branch
    run_vagrant provision $node $env "3-run-testing"
  fi
fi
exit $global_exit

