#!/usr/bin/env bash

test -f /etc/gitlab-ci.conf && sudo . /etc/gitlab-ci.conf
default_nodes=$catalag_preview_default_nodes
always_nodes=$catalag_preview_always_nodes

# Default number of commits to check for changed files
diff_commits_number=1

env=$1

if [[ "x$env" != "x" ]]; then
  git checkout $env
fi
diff_commits_number=$(git log production..$env --pretty=oneline | wc -l)
echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff production..$env --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q 'hieradata/hostname'; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/hostname\///" -e "s/\.yaml//")
  fi
#  if [[ $(echo "$changedfile" | grep -q 'hieradata/role'; echo $?) -eq 0 ]]; then
#    role=$(echo $changedfile | sed -e "s/^hieradata\/role\///" -e "s/\.yaml//")
#  fi

  if [[ "x$node" != "x" ]]; then
    echo
    echo "Puppet preview diff on ${node} - Check based on commits"
    sudo /opt/puppetlabs/bin/puppet preview --baseline_environment production --preview_environment $env $node
  fi
done

for node in $default_nodes; do
  echo
  echo "Catalog preview on ${node} - Default check"
  sudo /opt/puppetlabs/bin/puppet preview --baseline_environment production --preview_environment $env $node
done

for node in $always_nodes; do
  echo
  echo "Catalog preview on ${node} - Check always done"
  sudo /opt/puppetlabs/bin/puppet preview --baseline_environment production --preview_environment $env $node
done
