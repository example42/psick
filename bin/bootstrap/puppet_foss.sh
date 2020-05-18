#!/bin/bash
hostname=$(hostname)

vagrant/bin/vagrant-sethostname.sh $hostname
vagrant/bin/vagrant-sethosts.sh $hostname 127.0.0.1
bin/puppet_set_external_facts.sh --role='puppet' --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
bin/puppet_set_trusted_facts.sh --role='puppet' --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
bin/puppet_install.sh '5'
vagrant/bin/vagrant-setup_puppetserver.sh 'host'
bin/puppet_deploy_controlrepo.sh
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true

