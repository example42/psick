#!/bin/bash
lock_file='/var/tmp/vagrant-setup_papply.lock'
puppet_env=${1:-production}

setup() {
  if [ $(facter osfamily) == 'Debian' ]; then
    puppet resource package ruby ensure=present
  else
    puppet resource package rubygems ensure=present
  fi

  echo "### Installing gems with provider gem"
  puppet resource package hiera-eyaml provider=gem ensure=present
  puppet resource package deep_merge provider=gem ensure=present
  echo "### Installing gems with provider puppet_gem"
  puppet resource package hiera-eyaml provider=puppet_gem ensure=present
  puppet resource package deep_merge provider=puppet_gem ensure=present
}

# Run setup only the first time
if [ -f $lock_file ]; then
  echo "### Found $lock_file. Skipping installation of dependencies needed for puppet apply mode"
  echo "## Remove $lock_file on the Vagrant VM to retry their installation"
else
  echo "### Installing dependencies needed for puppet apply mode"
  setup && touch $lock_file
fi
