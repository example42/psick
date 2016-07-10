#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"

if [ "$1" = "unattended" ]; then
  echo_subtitle "Unattended mode"
else 
  ask_interactive "We are going to install the deep_merge, hiera-eyaml and r10k gems and, via r10k, the modules listed in Puppetfile under the modules directory."
fi

echo_title "Installing gems"
puppet resource package rubygems ensure=present
which gem || echo "You need gem support! Install rubygems to continue successfully" 
echo
echo_subtitle "Installing with /bin/gem"
gem install deep_merge
gem install hiera-eyaml
gem install r10k
echo_subtitle "Installing with /opt/puppetlabs/puppet/bin/gem"
/opt/puppetlabs/puppet/bin/gem install deep_merge
/opt/puppetlabs/puppet/bin/gem install hiera-eyaml
/opt/puppetlabs/puppet/bin/gem install r10k

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
  which $prog || echo "${prog} not found. Installation is recommended."
  echo
done
