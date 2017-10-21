#!/bin/bash
script_dir="$(dirname $0)"
. "${script_dir}/functions"
backup_dir="/etc/puppetlabs/code_backup"
backup_date=$(date +'%Y%m%d-%H%M%S')
environment=${1:-production}
PATH=$PATH:/usr/local/bin

echo_title "Installing prerequisite packages and gems"

puppet resource package git ensure=present

if [ $(facter osfamily) == 'Debian' ]; then
  puppet resource package ruby ensure=present
else
  puppet resource package rubygems ensure=present
fi

puppet resource package deep_merge ensure=present provider=gem
puppet resource package hiera-eyaml ensure=present provider=gem
puppet resource package r10k ensure=present provider=gem

mkdir -p /etc/puppetlabs/code/environments/

if [ -d /etc/puppetlabs/code/environments/$environment ]; then
  ask_interactive "Directory /etc/puppetlabs/code/environments/$environment exists. We have to move it."
  if [ "$?" = 0 ]; then
    mkdir -p $backup_dir
    mv /etc/puppetlabs/code/environments/$environment "${backup_dir}/${environment}-${backup_date}"
    echo_subtitle "/etc/puppetlabs/code/environments/$environment moved to ${backup_dir}/${environment}-${backup_date}"
  else
    echo "Can't proceed. Remove /etc/puppetlabs/code/environments/$environment or pass as argument a different environment"
    exit 1
  fi
fi
echo title "Cloning git://github.com/example42/psick.git to /etc/puppetlabs/code/environments/$environment"
git clone git://github.com/example42/psick.git /etc/puppetlabs/code/environments/$environment
cd /etc/puppetlabs/code/environments/$environment
echo_title "Running r10k puppetfile install -v"
r10k puppetfile install -v
echo_title "Moving /etc/puppetlabs/puppet/hiera.yaml to /etc/puppetlabs/puppet/hiera.yaml.orig"
mv /etc/puppetlabs/puppet/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml.orig
