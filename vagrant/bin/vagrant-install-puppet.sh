#!/bin/bash
lock_file=/var/tmp/vagrant-setup.lock

# Run setup only the first time
if [ -f $lock_file ]; then
  echo "### Found $lock_file. Skipping installation of Puppet."
  echo "## Remove $lock_file on the Vagrant VM to retry Puppet installation"
else
  echo "### Installing Puppet 4"
  wget -O - https://bit.ly/installpuppet | bash && touch $lock_file
fi


