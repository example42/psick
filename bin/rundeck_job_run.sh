#!/usr/bin/env bash


repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

results_dir="${repo_dir}/tests/rundeck/$(date +%Y%m%d-%H%M%S)"
mkdir -p $results_dir

test -f /etc/gitlab-ci.conf && . /etc/gitlab-ci.conf

env=$1
default=${env}_query_default_nodes
always=${env}_query_always_nodes
default_nodes=${!default}
always_nodes=${!always}
nodes=0
global_exit=0
rdjobid=$(rd jobs list -G "Remote Command Execution" -J "Execute Puppet Agent command" --outformat %id)

if [[ "x$1" != "x" ]]; then
  git checkout $1
  git pull
fi

runjob (){
  echo
  echo_title "Running Puppet on node ${1} - Check based on $2"
  outfile=$results_dir/runjob.out    
  rd run --id "${rdjobid}"  -F $1 -f -l verbose -- -noop true |tee $outfile
  exitcode=$PIPESTATUS
  if [ $exitcode -eq 1 ]; then
    exitcode=$(cat $outfile | grep "Run of Puppet configuration client already in progress")
  elif [ $exitcode -eq 2 ]; then
    exitcode=0
  else
    exitcode=1
  fi
  global_exit=$(($global_exit + $exitcode))
  rm -f $outfile
}

diff_commits_number=$(git log origin/production..$1 --pretty=oneline | wc -l)

echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff HEAD~$diff_commits_number --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q 'hieradata/nodes'; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/nodes\///" -e "s/\.yaml//")
    nodes=$nodes+1
  fi

  if [[ "x$node" != "x" ]]; then
    runjob "$node" "commits"
  fi
done

# Default nodes to check if none found from the commit
if [[ $nodes == 0 ]]; then
  for node in ${default_nodes//,/ }; do
    runjob "$node" "Default node"
  done
fi

for node in ${always_nodes//,/ }; do
  runjob "$node" "Always run node"
done

exit $global_exit
