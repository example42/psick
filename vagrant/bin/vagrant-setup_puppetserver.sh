#!/bin/bash
puppetserver_lock_file='/var/tmp/vagrant-setup_puppetserver.lock'
# puppet_env=${1:-production}

setup_puppetserver() {
  echo "### Installing git"
  puppet resource package git ensure=present
  echo "### Install puppetserver (onyl if not PE)"
  if ! [ -f /usr/lib/systemd/system/pe-puppetserver.service ]; then
    puppet resource package puppetserver ensure=present
  fi
  which puppetserver 2>/dev/null
  if [ "x$?" == "x0" ]; then
    echo "### Installing gems for puppetserver"
    puppetserver gem install hiera-eyaml
    puppetserver gem install deep_merge
    if [ -f /usr/lib/systemd/system/pe-puppetserver.service ]; then
      service pe-puppetserver restart
    else
      service puppetserver restart
    fi
  else
    return 1
  fi
}

# Run server setup only in Puppet server is installed
if [ -f $puppetserver_lock_file ]; then
  echo "### Found $puppetserver_lock_file. Skipping installation of dependencies needed for puppet server"
  echo "## Remove $puppetserver_lock_file on the Vagrant VM to retry their installation"
else
  echo "### Installing dependencies needed for puppet server"
  setup_puppetserver
  if [ "x$?" == "x0" ]; then
    touch $puppetserver_lock_file
  fi
fi
