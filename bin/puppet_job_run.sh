#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

test -f /etc/gitlab-ci.conf && . /etc/gitlab-ci.conf
env=$1
default=${env}_query_default_nodes
always=${env}_query_always_nodes
default_nodes=${!default}
always_nodes=${!always}
nodes=0
global_exit=0
domain=$(facter domain)

diff_commits_number=$(git log production..$1 --pretty=oneline | wc -l)

echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff HEAD~$diff_commits_number --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q "^hieradata/nodes" | grep $domain ; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/nodes\///" -e "s/\.yaml//")
    nodes=$nodes+1
  fi

  if [[ "x$node" != "x" ]]; then
    echo
    echo_title "Running Puppet on node ${node} - Check based on commits"
    puppet job run --nodes $node
    if [ $? != 0 ]; then
      global_exit=1
    fi
  fi
done

# Default nodes to check if none found from the commit
if [[ $nodes == 0 ]]; then
  echo_title "Running Puppet on nodes ${default_nodes} - Default nodes"
  puppet job run --nodes $default_nodes
  if [ $? != 0 ]; then
    global_exit=1
  fi
fi

echo_title "Running Puppet on nodes ${always_nodes} - Node always checked"
puppet job run --nodes $always_nodes
if [ $? != 0 ]; then
  global_exit=1
fi

exit $global_exit

