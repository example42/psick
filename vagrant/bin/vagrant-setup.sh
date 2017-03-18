#!/bin/bash
breed=$1
lock_file=/var/tmp/vagrant-setup.lock

setup_puppetlabs() {
  echo "## Using an official Puppet vagrant box. Installation skipped."
}

setup_puppetlabs-centos7() {
  echo "## Updating Puppet repo."
  rpm -e puppetlabs-release-pc1
  rpm -i https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
}

setup_puppetlabs-apt() {
  echo "## Running apt-get update"
  apt-get update >/dev/null 2>&1

  echo "## Using an official Puppet vagrant box. Installation skipped."
}

setup_puppetlabs-centos6() {
  echo "## Cleaning up existing ruby and puppet installations"
  yum erase -y ruby puppet
  rpm -e puppetlabs-release-pc1

  echo "## Adding repo for Puppet 4"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm

  echo "## Installing Puppet 4"
  yum install -y puppet-agent
}

setup_centos5() {
  echo "## Removing existing repos and Puppet"
  yum remove -y puppetlabs-release puppet facter

  echo "## Adding repo for Puppet 4"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-5.noarch.rpm >/dev/null # 2>&1

  echo "## Installing Puppet"
  yum install -y puppet-agent >/dev/null 2>&1
}

setup_redhat6() {
  echo "## Removing existing repos and Puppet"
  yum remove -y puppetlabs-release puppet facter

  echo "## Adding repo for Puppet 4"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm >/dev/null # 2>&1

  echo "## Installing Puppet"
  yum install -y puppet-agent >/dev/null 2>&1
}

setup_redhat7() {
  echo "## Removing existing repos and Puppet"
  yum remove -y puppetlabs-release puppet facter

  echo "## Adding repo for Puppet 4"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm >/dev/null # 2>&1

  echo "## Installing Puppet"
  yum install -y puppet-agent >/dev/null 2>&1
}

setup_puppetlabs-ubuntu1204() {
  echo "## Running apt-get update"
  apt-get update >/dev/null

  echo "## Installing Ruby 1.9.3"
  apt-get install -y ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev  >/dev/null
  update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
     --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
               /usr/share/man/man1/ruby1.9.1.1.gz \
     --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
     --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
     --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1

  update-alternatives --config ruby
  update-alternatives --config gem
}

setup_debian8() {
  echo "## Adding repo for Puppet 4"
  wget -q http://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb >/dev/null
  dpkg -i puppetlabs-release-pc1-jessie.deb >/dev/null 2>&1

  echo "## Running apt-get update"
  apt-get update >/dev/null 2>&1

  echo "## Installing Puppet and its dependencies"
  apt-get install puppet-agent -y >/dev/null 2>&1
  apt-get install apt-transport-https -y >/dev/null 2>&1
}

setup_debian() {
  dist=$( cat /etc/apt/sources.list | grep updates | grep 'deb http' | cut -d ' ' -f 3 | cut -d "/" -f 1)
  deb_install $dist
}

setup_ubuntu() {
  dist=$( cat /etc/lsb-release | grep DISTRIB_CODENAME | cut -d '=' -f 2)
  deb_install $dist
}

deb_install() {
  dist=$1
  echo "## Adding repo for Puppet 4"
  wget -q "http://apt.puppetlabs.com/puppetlabs-release-pc1-${dist}.deb" >/dev/null 2>&1
  dpkg -i "puppetlabs-release-pc1-${dist}.deb" >/dev/null 2>&1

  echo "## Running apt-get update"
  apt-get update >/dev/null 2>&1

  echo "## Installing Puppet and its dependencies"
  apt-get install puppet-agent -y >/dev/null 2>&1
  apt-get install apt-transport-https -y >/dev/null 2>&1
}

setup_opensuse12(){
  echo "## Installing Puppet repository"
  zypper addrepo -f http://download.opensuse.org/repositories/systemsmanagement:/puppet/SLE_11_SP4/ puppet

  echo "## Installing Puppet and its dependencies"
  zypper install -y puppet
}

setup_sles12(){
  echo "## Installing Puppet repository"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-sles-12.noarch.rpm >/dev/null # 2>&1

  echo "## Installing Puppet"
  yum install -y puppet-agent >/dev/null 2>&1
}
  
setup_sles11(){
  echo "## Installing Puppet repository"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-sles-11.noarch.rpm >/dev/null # 2>&1

  echo "## Installing Puppet"
  yum install -y puppet-agent >/dev/null 2>&1
}
  
setup_alpine() {
  echo "## Adding repo for Puppet 4"
  echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories
  apk update

  echo "## Installing Puppet and its dependencies"
  apk add shadow ruby less bash
  gem install puppet --no-rdoc -no-ri
}

# Run setup only the first time
if [ -f $lock_file ]; then
  echo "### Found $lock_file. Skipping installation of Puppet."
  echo "## Remove $lock_file on the Vagrant VM to retry Puppet installation"
else
  echo "### Installing Puppet 4"
  setup_$breed && touch $lock_file
fi


