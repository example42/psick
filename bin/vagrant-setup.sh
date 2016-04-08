#!/bin/bash
breed=$1
lock_file=/var/tmp/vagrant-setup.lock

setup_puppetlabs() {
  echo "## Using a PuppetLabs vagrant box. No Puppet setup activity needed"
}

setup_puppetlabs-apt() {
  echo "## Running apy-get update"
  apt-get update >/dev/null

  echo "## Using a PuppetLabs vagrant box. No Puppet setup activity needed"
}

setup_puppetlabs-centos6() {
#  echo "## Installing Ruby 1.9.3
#  yum install -y centos-release-SCL
#  yum install -y ruby193
#  echo "source /opt/rh/ruby193/enable" | sudo tee -a /etc/profile.d/ruby193.sh

  echo "## Cleaning up existing ruby and puppet installations"
  yum erase -y ruby puppet

  echo "## Installing PuppetLabs repo for Puppet 4"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm

  echo "## Installing Puppet 4"
  yum install -y puppet-agent
}

setup_centos5() {
  echo
}

setup_redhat7() {
  echo "## Installing Puppetlabs repo"
  rpm -ivh https://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-7-11.noarch.rpm >/dev/null # 2>&1

  echo "## Installing Puppet"
  yum install -y puppet >/dev/null 
}

setup_puppetlabs-ubuntu1204() {
  echo "## Running apy-get update"
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
  echo "## Installing Puppetlabs repository"
  wget -q http://apt.puppetlabs.com/puppetlabs-release-jessie.deb >/dev/null
  dpkg -i puppetlabs-release-jessie.deb >/dev/null

  echo "## Running apy-get update"
  apt-get update >/dev/null 2>&1

  echo "## Installing Puppet and its dependencies"
  apt-get install puppet -y >/dev/null
  apt-get install apt-transport-https -y >/dev/null
}

setup_opensuse12(){
  echo "## Installing Puppetlabs repository"
  zypper addrepo -f http://download.opensuse.org/repositories/systemsmanagement:/puppet/SLE_11_SP4/ puppet

  echo "## Installing Puppet and its dependencies"
  zypper install -y puppet
}

# Run setup only the first time
[ -f $lock_file ] || setup_$breed && touch $lock_file
