#!/bin/bash
repo_dir="$(dirname $0)/.."
script_dir="$(dirname $0)"
# repo_dir=$(git rev-parse --show-toplevel)
. "${script_dir}/functions"

PATH=$PATH:/usr/local/bin
if [ "$1" = "auto" ]; then
  auto=true
fi

install_gems() {
  echo_title "This script setups the Puppet environment"
  echo "We need the following Ruby gems: r10k, hiera-eyaml, deep_merge"
  [ "$auto" = "true" ] || ask_interactive "Shall we install the needed gems? Skip if you can care of them."
  [ "$?" = 0 ] || return

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
  if [ -x /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem ]; then
    echo_subtitle "Installing with /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem"
    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install deep_merge
    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install hiera-eyaml
    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install r10k
  fi
}

install_rsync() {
  echo_title "Installing rsync"
  [ "$auto" = "true" ] || ask_interactive "Can we install rsync? Note: You need sudo powers"
  [ "$?" = 0 ] || return
  sudo -E puppet resource package rsync ensure=present
}

install_modules() {
  cd $repo_dir
  echo_title "Installing external modules via r10k"
  [ "$auto" = "true" ] || ask_interactive "Shall we run r10k puppetfile install -v to install Puppet modules under modules/ ? We need them! :-)"
  [ "$?" = 0 ] || return
  r10k puppetfile install -v
  echo
}

install_gems
install_rsync
install_modules

progs="puppet vagrant docker fab"
for prog in $progs; do
  echo_subtitle "Checking ${prog} availability"
  which $prog && echo_success "${prog} found. Good!" || echo_failure "${prog} not found. Installation is recommended."
  echo
done
