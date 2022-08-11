#!/usr/bin/env bash
PATH=$PATH:/opt/puppetlabs/puppet/bin

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

# This script is used to reset to clean state Code Manager on Puppet Enterprise.
# It's going to remove files and dirs from caches of the git repos used during
# deployments. After this script has been run, you will have to run a puppet-code deploy --all
# to redeploy environments.

# Some of the following commands should be executed an all servers (primary, replace, compilers).
# This script is OK as is in a standalone PE setup.

# All PE servers
puppet resource service pe-puppetserver ensure=stopped

# Primary server
puppet resource service pe-orchestration-services ensure=stopped

# All PE servers
find /etc/puppetlabs/code -mindepth 1 -delete
mkdir -p /etc/puppetlabs/code/environments/production
chown -R pe-puppet:pe-puppet /etc/puppetlabs/code
chmod 755 /etc/puppetlabs/code/environments
chmod 750 /etc/puppetlabs/code/environments/production

# Primary server
mv /etc/puppetlabs/code-staging /etc/puppetlabs/code-staging.old
mkdir /etc/puppetlabs/code-staging
chown pe-puppet:pe-puppet /etc/puppetlabs/code-staging
chmod 750 /etc/puppetlabs/code-staging

# All PE servers
rm -rf /opt/puppetlabs/server/data/code-manager/git/
rm -rf /opt/puppetlabs/server/data/code-manager/worker-caches/
rm -rf /opt/puppetlabs/server/data/orchestration-services/data-dir
rm -rf /opt/puppetlabs/server/data/orchestration-services/code
rm -rf /opt/puppetlabs/server/data/puppetserver/filesync

# PostgreSQL server (primary)
sudo su - pe-postgres -s /bin/bash -c "/opt/puppetlabs/server/bin/psql -d 'pe-classifier' -c \"UPDATE environments SET deleted = 'f' WHERE deleted = 't';\""

# Primary server
puppet apply -e "pe_hocon_setting { 'cache': ensure => present, path => '/etc/puppetlabs/puppetserver/conf.d/pe-puppet-server.conf', setting => 'jruby-puppet.environment-class-cache-enabled', value => false }"

puppet resource service pe-puppetserver ensure=running
puppet resource service pe-orchestration-services ensure=running