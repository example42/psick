#!/usr/bin/env bash
test -f /etc/gitlab-ci.conf && . /etc/gitlab-ci.conf
env=$1
#default_nodes=$(eval echo "${env}_query_default_nodes")
#always_nodes=$(eval echo "${env}_query_always_nodes")
default=${env}_query_default_nodes
always=${env}_query_always_nodes
default_nodes=${!default}
always_nodes=${!always}

diff_commits_number=1
nodes=0
global_exit=0
certname=$(puppet config print certname)
if [[ "x$1" != "x" ]]; then
  git checkout $1
  git pull
fi
diff_commits_number=$(git log origin/production..$1 --pretty=oneline | wc -l)

check_node() {
  sudo /opt/puppetlabs/bin/puppet-query  --cacert=/etc/puppetlabs/puppet/ssl/certs/ca.pem --cert=/etc/puppetlabs/puppet/ssl/certs/$certname.pem --key=/etc/puppetlabs/puppet/ssl/private_keys/$certname.pem "nodes[certname] { latest_report_status = 'failed' and expired is null and catalog_environment = '${env}' }" | grep $1
  if [ "x$?" == "x0" ]; then
    echo "Node ${1} last run has failed!"
    global_exit=1
  else
    echo "Node ${1} last run was successfull"
  fi
}

echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff HEAD~$diff_commits_number --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q 'hieradata/nodes'; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/nodes\///" -e "s/\.yaml//")
    nodes=$nodes+1
  fi

  if [[ "x$node" != "x" ]]; then
    echo
    echo "Check last report status of ${node} - Check based on commits"
    check_node $node
  fi
done

# Default nodes to check if none found from the commit
if [[ $nodes == 0 ]]; then
  for node in ${default_nodes//,/ }; do
    echo
    echo "Check last report status of ${node} - Default node"
    check_node $node
  done
fi

# Nodes to check always
for node in ${always_nodes//,/ }; do
  echo
  echo "Check last report status of ${node} - Node always checked"
  check_node $node
done

exit $global_exit

