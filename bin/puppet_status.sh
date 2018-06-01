#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

showhelp() {
cat <<HELP
This script shows information about what Puppet manages locally. It can used
either locally or on a remote node.
Usage: ${0} <action> [--env <environment>] [--ssh <ssh_connection>]
Available actions:
  resources - Lists the resources managed by Puppet on the local node
  last_run_summary - Show the content of /opt/puppetlabs/puppet/cache/state/last_run_summary.yaml
  filebucket - Show filebucketed files under /opt/puppetlabs/puppet/cache/clientbucket/
Example: $0 resources --ssh jenkins@web01
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
    resources)
      echo_title "Showing Puppet managed resources on this node"
      $ssh_command
      $sudo_command cat /opt/puppetlabs/puppet/cache/state/state.yaml | grep -v "^  " | grep -v "^---$" | sort | sed 's/:$//g'
      $ssh_command_post
    ;;
    last_run_summary)
      echo_title "Showing Puppet's last run summary"
      $ssh_command
      $sudo_command cat /opt/puppetlabs/puppet/cache/state/last_run_summary.yaml
      $ssh_command_post
    ;;
    filebucket)
      echo_title "Showing files backupped in the filebucket"
      $ssh_command
      $sudo_command find /opt/puppetlabs/puppet/cache/clientbucket/ -name paths -exec sh -c 'cat  "$1" | tr "\n" " " ; stat -c %y "$1" ' _ {} \;
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
    resources)
      action='resources'
      shift
    ;;
    last_run_summary)
      action='last_run_summary'
      shift
    ;;
    filebucket)
      action='filebucket'
      shift
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

run_action $action $node


