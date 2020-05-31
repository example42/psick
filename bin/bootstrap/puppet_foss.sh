#!/bin/bash
puppet_version=$1
echo "Set external facts"
bin/puppet_set_external_facts.sh --role='puppet' --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
echo "Set trusted facts"
bin/puppet_set_trusted_facts.sh --role='puppet' --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
echo "Install puppet"
bin/puppet_install.sh $puppet_version
echo "Deploy Puppet Master"
vagrant/bin/vagrant-setup_puppetserver.sh 'host'
echo "Deploy control-repository"
bin/puppet_deploy_controlrepo.sh
echo "Starting Puppet Server"
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true

