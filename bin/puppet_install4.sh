#!/usr/bin/env bash
breed=$1

SETCOLOR_NORMAL=$(tput sgr0)
SETCOLOR_TITLE=$(tput setaf 6)
SETCOLOR_SUBTITLE=$(tput setaf 14)
SETCOLOR_BOLD=$(tput setaf 15)
echo_title () {
  echo
  echo "${SETCOLOR_BOLD}###${SETCOLOR_NORMAL} ${SETCOLOR_TITLE}${1}${SETCOLOR_NORMAL} ${SETCOLOR_BOLD}###${SETCOLOR_NORMAL}"
}

echo_title "Checking Puppet installation"

setup_puppetlabs-centos6() {
#  echo_title "Installing Ruby 1.9.3
#  yum install -y centos-release-SCL
#  yum install -y ruby193
#  echo "source /opt/rh/ruby193/enable" | sudo tee -a /etc/profile.d/ruby193.sh

  echo_title "Cleaning up existing ruby and puppet installations"
  yum erase -y ruby puppet

  echo_title "Adding repo for Puppet 4"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm

  echo_title "Installing Puppet 4"
  yum install -y puppet-agent
}

setup_redhat7() {
  echo_title "Uninstalling existing Puppet"
  yum erase -y puppet >/dev/null 

  echo_title "Adding repo for Puppet 4"
  rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

  sleep 2
  echo_title "Installing Puppet"
  yum install -y puppet-agent 
}

setup_puppetlabs-ubuntu1204() {
  echo_title "Running apt-get update"
  apt-get update >/dev/null

  echo_title "Installing Ruby 1.9.3"
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
  echo_title "Adding repo for Puppet 4"
  wget -q http://apt.puppetlabs.com/puppetlabs-release-jessie.deb >/dev/null
  dpkg -i puppetlabs-release-jessie.deb >/dev/null

  echo_title "Running apt-get update"
  apt-get update >/dev/null 2>&1

  echo_title "Installing Puppet and its dependencies"
  apt-get install puppet -y >/dev/null
  apt-get install apt-transport-https -y >/dev/null
}

setup_opensuse12(){
  echo_title "Installing Puppet repository"
  zypper addrepo -f http://download.opensuse.org/repositories/systemsmanagement:/puppet/SLE_11_SP4/ puppet

  echo_title "Installing Puppet and its dependencies"
  zypper install -y puppet
}

setup_alpine() {
  echo_title "Adding repo for Puppet 4"
  echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories
  apk update

  echo_title "Installing Puppet and its dependencies"
  apk add shadow ruby less bash
  gem install puppet --no-rdoc -no-ri
}

setup_$breed 
