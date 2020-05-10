#!/bin/bash
if [ -z $1 ]; then
  echo 'No IP Address provided. Terminating.'
  exit 1
else
  ip=$1
fi
hostname=$(hostname)

vagrant/bin/vagrant-sethostname.sh $hostname
vagrant/bin/vagrant-sethosts.sh $hostname $ip
bin/puppet_set_external_facts.sh --role='puppet' --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
bin/puppet_set_trusted_facts.sh --role='puppet' --env 'host' --zone 'foss' --da
tacenter 'vagrant' --application 'puppetinfra'
vagrant/bin/puppet_install.sh '5'
vagrant/bin/vagrant-setup_puppetserver.sh 'host'
bin/puppet_deploy_controlrepo.sh

