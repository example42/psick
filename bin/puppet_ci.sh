#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

showhelp() {
cat <<HELP
This script executes, locally or on a remote node, a set of Puppet CI related actions.
Usage: ${0} <action> [--env <environment>] [--ssh <ssh_connection>]
Available actions:
  tp_test - Runs 'tp test'
  catalog_preview -
  catalog_diff -
  job_run - Use puppet job to trigger a remote Puppet run
  db_query -
  task_run -
  puppet_deploy -
Example: $0 tp_test --ssh jenkins@web01
HELP
}

# We want to live in Puppet space
export PATH=/opt/puppetlabs/puppet/bin:$PATH

# Configuration file of this script (not an official Puppet configuation)
# Managed by psick::puppet::ci
test -f /etc/puppetlabs/ci.conf && . /etc/puppetlabs/ci.conf

# run_action function runs different commands according to the provided task
run_action () {
  a=$1
  n=$2
  case "$a" in
    tp_test)
      $ssh_command
      $sudo_command tp test
      $ssh_command_post
    ;;
    catalog_preview)
      $ssh_command
      $sudo_command puppet preview --view overview --assert equal --baseline_environment production --preview_environment $env $n
      $ssh_command_post
    ;;
    catalog_diff)
      $ssh_command
      $sudo_command octocatalog-diff -n $n
      $ssh_command_post
    ;;
    job_run)
      $ssh_command
      $sudo_command puppet job run --nodes $n --environment $env $noop --description "$description"
      $ssh_command_post
    ;;
    db_query)
      $ssh_command
      certname=$(puppet config print certname)
      $sudo_command puppet-query  --cacert=/etc/puppetlabs/puppet/ssl/certs/ca.pem --cert=/etc/puppetlabs/puppet/ssl/certs/$certname.pem --key=/etc/puppetlabs/puppet/ssl/private_keys/$certname.pem "nodes[certname] { latest_report_status = 'failed' and expired is null and catalog_environment = '${env}' }" | grep $n
      if [ "x$?" == "x0" ]; then
        echo "Node ${n} last run has failed!"
        exit 1
      else
        echo "Node ${n} last run was successfull"
        exit 0
      fi
      $ssh_command_post
    ;;
    task_run)
      $ssh_command
      $sudo_command bolt task run $task environment=$env -n $n
      $ssh_command_post
    ;;
    git_deploy)
      $ssh_command
      $sudo_command "cd /etc/puppetlabs/code/environments/${env}/ ; git pull origin ${env} ; r10k puppetfile install"
      $ssh_command_post
    ;;
    r10k_deploy)
      $ssh_command
      $sudo_command /opt/puppetlabs/puppet/bin/r10k deploy environment ${env} -v
      $ssh_command_post
    ;;
    *)
      echo_failure "Action not supported"
      showhelp
      exit 1
    ;;
  esac
}

# Params parsing
# Check Input
if [ "$#" = "0" ] ; then
    showhelp
    exit
fi

ssh_command=''
ssh_command_post=''
sudo_command=''
env='production'
action='showhelp'
description='[CI]'
while [ $# -gt 0 ]; do
  case "$1" in
    tp_test)
      action='tp_test'
      shift
    ;;
    catalog_preview)
      action='catalog_preview'
      shift
    ;;
    catalog_diff)
      action='catalog_diff'
      shift
    ;;
    job_run)
      action='job_run'
      noop=${2:- }
      shift 2
    ;;
    db_query)
      action='db_query'
      shift
    ;;
    task_run)
      action='task_run'
      task=$2
      shift 2
    ;;
    git_deploy)
      action='git_deploy'
      shift
    ;;
    r10k_deploy)
      action='r10k_deploy'
      shift
    ;;
    --environment|--env|-e)
      env=$2
      shift 2
    ;;
    --description|--desc|-d)
      description=$2
      shift 2
    ;;
    --ssh)
      ssh_command="ssh $2 <<SSHCMD"
      ssh_command_post="SSHCMD"
      shift 2
    ;;
    --sudo)
      sudo_command='sudo'
      shift
    ;;
    *)
      showhelp
      exit
    ;;
  esac
done

# Vars
default=${${env}_${action}_default_nodes:-$default_nodes}
always=${${env}_${action}_always_nodes:-$always_nodes}
default_nodes=${!default}
always_nodes=${!always}
if [[ "$nodes_format" == "space" ]]; then
  default_nodes=${default_nodes//,/ }
  always_nodes=${always_nodes//,/ }
fi
nodes=0
global_exit=0
diff_commits_number=$(git log production..$1 --pretty=oneline | wc -l)

echo "Checking for files in the last $diff_commits_number commits"
for changedfile in $(git diff HEAD~$diff_commits_number --name-only); do
  node=''
  if [[ $(echo "$changedfile" | grep -q 'hieradata/nodes'; echo $?) -eq 0 ]]; then
    node=$(echo $changedfile | sed -e "s/^hieradata\/nodes\///" -e "s/\.yaml//")
    nodes=$nodes+1
  fi

  if [[ "x$node" != "x" ]]; then
    echo
    echo_title "Running ci action ${action} on node ${node} - Check based on commits"
    run_action $action $node
    if [ $? != 0 ]; then
      global_exit=1
    fi
  fi
done

# Default nodes to check if none found from the commit
if [[ $nodes == 0 ]]; then
  for node in ${default_nodes}; do
    echo_title "Running ci action ${action} on node ${node} - Check based on commits"
    run_action $action $node
    if [ $? != 0 ]; then
      global_exit=1
    fi
  done
fi

# Nodes where to run always the selected ci action
for node in ${always_nodes}; do
  echo_title "Running ci action ${action} on node ${node} - Node always checked"
  run_action $action $node
  if [ $? != 0 ]; then
    global_exit=1
  fi
done

exit $global_exit

