#!/bin/bash
echo -e "10.0.1.1 puppet\n10.0.1.2 gitlab\n" >> /etc/hosts
puppet_version=$1
puppet_role=$2
control_repo=$3

yum install -y git
git clone $control_repo /tmp/psick
pushd /tmp/psick
echo "Set external facts"
bin/puppet_set_external_facts.sh --role $puppet_role --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
echo "Set trusted facts"
bin/puppet_set_trusted_facts.sh --role $puppet_role --env 'host' --zone 'foss' --datacenter 'vagrant' --application 'puppetinfra'
echo "Installing Puppet"
bin/puppet_install.sh $puppet_version
popd

if [ $puppet_role == 'puppet' ]; then
  pushd /tmp/psick

  echo "### Installing puppetserver"
  puppet resource package puppetserver ensure=present

  echo "### Installing puppetserver gems"
  /opt/puppetlabs/server/bin/puppetserver gem install hiera-eyaml
  /opt/puppetlabs/server/bin/puppetserver gem install deep_merge

  echo "Installing puppet agent gems"

  puppet resource package deep_merge ensure=present provider=puppet_gem
  puppet resource package hiera-eyaml ensure=present provider=puppet_gem
  puppet resource package r10k ensure=present provider=puppet_gem

  echo "Deploy control-repository"
  mkdir -p /etc/puppetlabs/code/environments/
  mkdir -p /etc/puppetlabs/r10k/
  cat > /etc/puppetlabs/r10k/r10k.yaml << EOF
---
:postrun: []
:cachedir: /opt/puppetlabs/puppet/cache/r10k
:sources:
  puppet:
    basedir: /etc/puppetlabs/code/environments
    remote: $control_repo
EOF

  echo "Running r10k deploy environment -v"
  /opt/puppetlabs/puppet/bin/r10k deploy environment -pv

  echo "Starting Puppet Server"
  /opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true
  popd
fi

rm -fr /tmp/psick

