#!/usr/bin/env bash
test -f /etc/gitlab-ci.conf && . /etc/gitlab-ci.conf
default_nodes=$tp_test_default_nodes
always_nodes=$tp_test_always_nodes

diff_commits_number=1

if [[ "x$1" != "x" ]]; then
  git checkout $1
  git pull
  diff_commits_number=$(git log origin/production..$1 --pretty=oneline | wc -l)
fi
echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff HEAD~$diff_commits_number --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q 'hieradata/nodes'; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/nodes\///" -e "s/\.yaml//")
  fi

  # Default nodes to check in common changes
  if [[ $(echo "$changedfile" | grep -q 'hieradata/role'; echo $?) -eq 0 ]] \
  || [[ $(echo "$changedfile" | grep -q 'Puppetfile'; echo $?) -eq 0 ]] \
  || [[ $(echo "$changedfile" | grep -q 'site/'; echo $?) -eq 0 ]] \
  || [[ $(echo "$changedfile" | grep -q 'manifests/'; echo $?) -eq 0 ]]; then
    for node in $default_nodes; do
      echo
      echo "Tp test on ${node} - Default check"
      vagrant ssh $node -c 'tp test ; exit $?'
    done
  fi

  if [[ "x$node" != "x" ]]; then
    echo
    echo "Tp test ${node} - Check based on commits"
    vagrant ssh $node -c 'tp test ; exit $?'
  fi
done

for node in $always_nodes; do
  echo
  echo "Tp test on ${node} - Check always done"
  vagrant ssh $node -c 'tp test ; exit $?'
  # fab tp.remote_test -H $node
done
