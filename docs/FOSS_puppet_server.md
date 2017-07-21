## example42 PSICK Puppet Open Source Server automation

The control-repo allows to spin up a Puppet Open Source Server in a fully automated way.

One can use vagrant or even use PSICK on a fresh base OS installation.

First we need puppet-agent and r10k installed.

### Vagrant installation

For vagrant it is required to have a local ruby installation. Best option is to either use rvm or rbenv. Then run ```bundle install --path vendor/bundle```.

Use bundle to install the modules from Puppetfile:

    bundle exec r10k puppetfile install -v

Now change to ```vagrant/environments/pos``` directory and run ```vagrant up puppet.foss.psick.io```.

## Base OS installation

For base OS installation the most easy way is cloning control-repo into /etc/puppetlabs/code/environments/production:

    mkdir -p /etc/puppetlabs/code/environments
    cd /etc/puppetlabs/code/environments
    git clone https://github.com/example42/psick.git production
    cd production

Next it is required tp have puppet-agent package already installed. This can be achieved by running ```bin/puppet_install.sh``` from PSICK base directory.
Next we need r10k installation by running ```bin/puppet_setup.sh``` from PSICK base directory.

One can ignore error message concerning docker, vagrant and fab.

Now we can install modules by using the r10k command to install required modules:

    ./bin/puppet_install_puppetfile.sh

Afterwards one needs to change the hiera node data to add the profile classification information:

      ---
      profiles:
        - profile::puppet::gems
        - profile::puppet::foss_master
      profile::puppet::gems::install_puppetserver_gems: true

Last step is to use puppet apply for getting the setup done automatically. Just run ```bin/papply.sh```.

