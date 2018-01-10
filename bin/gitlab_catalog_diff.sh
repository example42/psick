#!/usr/bin/env bash
test -f /etc/gitlab-ci.conf && . /etc/gitlab-ci.conf

default_nodes=$catalag_diff_default_nodes
always_nodes=$catalag_diff_always_nodes
default_branch='production'

diff_commits_number=1

if [[ "x$1" != "x" ]]; then
  git checkout $1
  git pull
fi
diff_commits_number=$(git log origin/$default_branch..$1 --pretty=oneline | wc -l)
echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff HEAD~$diff_commits_number --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q 'hieradata/nodes'; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/nodes\///" -e "s/\.yaml//")
  fi
  if [[ $(echo "$changedfile" | grep -q 'hieradata/role'; echo $?) -eq 0 ]]; then
    role=$(echo $changedfile | sed -e "s/^hieradata\/role\///" -e "s/\.yaml//")
  fi

  if [[ "x$node" != "x" ]]; then
    echo
    echo "Catalog diff on ${node} - Check based on commits"
    octocatalog-diff -n $node
  fi

  if [[ "x$role" != "x" ]]; then
    echo
    echo "Catalog diff on role ${role} - Check based on commits"
    octocatalog-diff -n $role.$(facter domain)
  fi
done

for node in $default_nodes; do
  echo
  echo "Catalog diff on ${node} - Default check"
  octocatalog-diff -n $node
done

for node in $always_nodes; do
  echo
  echo "Catalog diff on ${node} - Check always done"
  octocatalog-diff -n $node
done
