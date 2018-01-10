#!/usr/bin/env bash
test -f /etc/gitlab-ci.conf && . /etc/gitlab-ci.conf

default_nodes=$catalog_preview_default_nodes
always_nodes=$catalog_preview_always_nodes

# Default number of commits to check for changed files
diff_commits_number=1
global_exit=0
nodes=0

env=$1

if [[ "x$env" != "x" ]]; then
  git checkout $env
  git pull
fi
diff_commits_number=$(git log origin/production..$env --pretty=oneline | wc -l)
echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff origin/production..$env --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q 'hieradata/nodes'; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/nodes\///" -e "s/\.yaml//")
  fi

  if [[ "x$node" != "x" ]]; then
    echo
    echo "Puppet preview diff on ${node} - Check based on commits"
    sudo /opt/puppetlabs/bin/puppet preview --view overview --assert equal --baseline_environment production --preview_environment $env $node
    global_exit=$(($global_exit + $?))
    nodes=$nodes+1
  fi 
done

if [[ $nodes == 0 ]]; then
    for node in ${default_nodes//,/ }; do
      echo
      echo "Catalog preview on ${node} - Default check"
      sudo /opt/puppetlabs/bin/puppet preview --view overview --assert equal --baseline_environment production --preview_environment $env $node
      global_exit=$(($global_exit + $?))
    done
fi

for node in ${always_nodes//,/ }; do
  echo
  echo "Catalog preview on ${node} - Check always done"
  sudo /opt/puppetlabs/bin/puppet preview --view overview --assert equal --baseline_environment production --preview_environment $env $node
  global_exit=$(($global_exit + $?))
done
exit $global_exit
