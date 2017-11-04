## example42 PSICK Puppet Open Source Server automation

This control-repo allows to spin up a Puppet Open Source Server in a fully automated way.

One can use vagrant or even use PSICK on a fresh base OS installation.

First we need puppet-agent and r10k installed.

### Vagrant installation

For vagrant it is required to have a local ruby installation. Best option is to either use rvm or rbenv. Then run ```bundle install --path vendor/bundle```.

Use bundle to install the modules from Puppetfile:

    bundle exec r10k puppetfile install -v

Now change to ```vagrant/environments/pos``` directory and run ```vagrant up puppet.foss.psick.io```.

## Base OS installation

For base OS installation the easiest way is cloning control-repo into /etc/puppetlabs/code/environments/production:

    mkdir -p /etc/puppetlabs/code/environments
    cd /etc/puppetlabs/code/environments
    git clone https://github.com/example42/psick.git production
    cd production

Next it is required to have puppet-agent package already installed. We can install Puppet 5 agent running from PSICK base directory:

    bin/puppet_install.sh

Next we need to install r10k gem by running

    bin/puppet_setup.sh

We can ignore warnings about missing docker, vagrant and fab command.

Then, if not done via the puppet_setups.sh script, we have to install the modules defined in ```Puppetfile``` under the ```modules``` directory by using the r10k command:

    bin/puppet_install_puppetfile.sh

Now we are ready to assume the ```puppet_foss_master``` role and run Puppet locally, we do this setting as environment variable the role fact:

    export FACTER_role=puppet_foss_master

Finally just run:

    bin/papply.sh

to setup locally, via Puppet, a Puppet Server with PuppetDB. If you have errors at the first run (known ones are related to the used postgresql module) run the command again, until you see no changes on the system:

    bin/papply.sh
