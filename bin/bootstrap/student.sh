#!/bin/bash
puppet_version=$1
echo "Set external facts"
bin/puppet_set_external_facts.sh --role='student' --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
echo "Set trusted facts"
bin/puppet_set_trusted_facts.sh --role='student' --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
echo "Installing Puppet"
bin/puppet_install.sh $puppet_version

