#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"

PATH=$PATH:/usr/local/bin
if [ "$1" = "auto" ]; then
  auto=true
fi

echo_title "This scripts setups the Puppet environment"
echo "It asks to install the required Ruby gems: r10k, hiera-eyaml, deep_merge"
echo "Then it runs: r10k puppetfile install -v"
[ "$auto" = "true" ] || ask_interactive "Install the needed gems and then, via r10k, the modules listed in Puppetfile?"
[ "$?" = 0 ] || exit 1

echo_title "Installing gems"
puppet resource package rubygems ensure=present
which gem || echo "You need gem support! Install rubygems to continue successfully" 
echo
echo_subtitle "Installing with /bin/gem"
gem install deep_merge --no-ri --no-rdoc
gem install hiera-eyaml --no-ri --no-rdoc
gem install r10k --no-ri --no-rdoc
if [ -x /opt/puppetlabs/puppet/bin/gem ]; then
  echo_subtitle "Installing with /opt/puppetlabs/puppet/bin/gem"
  /opt/puppetlabs/puppet/bin/gem install deep_merge --no-ri --no-rdoc
  /opt/puppetlabs/puppet/bin/gem install hiera-eyaml --no-ri --no-rdoc
  /opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc
fi
if [ -x /opt/puppetlabs/bin/puppetserver ]; then
  echo_subtitle "Installing with /opt/puppetlabs/bin/puppetserver"
  /opt/puppetlabs/bin/puppetserver gem install deep_merge
  /opt/puppetlabs/bin/puppetserver gem install hiera-eyaml
  /opt/puppetlabs/bin/puppetserver gem install r10k
fi

echo_title "Installing rsync"
puppet resource package rsync ensure=present

echo 
cd $repo_dir
echo_title "Installing external modules via r10k"
r10k puppetfile install -v
echo

progs="puppet vagrant docker fab"
for prog in $progs; do
  echo_subtitle "Checking ${prog} availability"
  which $prog || echo_failure "${prog} not found. Installation is recommended."
  echo
done
