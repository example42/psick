
- [example42 PSICK Puppet Open Source Server automation](#example42-psick-puppet-open-source-server-automation)
    - [1. Vagrant installation](#1-vagrant-installation)
    - [2. Base OS installation](#2-base-os-installation)

## example42 PSICK Puppet Open Source Server automation

This `control-repo` allows to spin up a `Puppet Open Source Server` in a fully automated way.

One can use [vagrant](https://www.vagrantup.com/) or even use `PSICK` on a fresh base OS installation.

First we need `puppet-agent` and `r10k` installed.

### 1. Vagrant installation

For ```vagrant``` it is required to have a local `ruby` installation. Best option is to either use [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv). Then run ```bundle install --path vendor/bundle```.

Use ```bundle``` to install the modules via ```r10k``` from ```Puppetfile```:

    bundle exec r10k puppetfile install -v

Now change to ```vagrant/environments/pos``` directory and run ```vagrant up puppet.foss.psick.io```.

### 2. Base OS installation

To install the `FOSS Puppet Server` with `PuppetDB` on a vanilla OS (tested ```RedHat 7``` derivatives and ```Ubuntu 16.04```) the easiest way is cloning `control-repo` into ```/etc/puppetlabs/code/environments/production``` folder and apply the **puppet_foss_master** role:

    mkdir -p /etc/puppetlabs/code/environments
    cd /etc/puppetlabs/code/environments
    git clone https://github.com/example42/psick.git production
    cd production

Next it is required to have `puppet-agent` package already installed. We can install `Puppet 5 agent` running from `PSICK` base directory:

    bin/puppet_install.sh

Next we need to populate the modules directory with the contents of the ```Puppetfile```, we can run, if we have already `r10k` installed:

    r10k puppetfile install -v

or if we want to install `r10k` (and other recommended gems) in an unattended way and then run it:

    bin/puppet_setup.sh auto

We can ignore warnings about missing ```docker```, ```vagrant``` and ```fab``` commands.

Now we are ready to assign the ```puppet_foss_master``` role and run `Puppet` locally, we do this by setting the role as [external fact](external_facts.md):

    bin/puppet_set_external_facts.sh --role puppet_foss_master

Finally just run:

    bin/papply.sh

to setup locally, via `Puppet`, a `Puppet Server` with `PuppetDB`. If you have errors at the first run (known ones are related to the used postgresql module) run the command again, until you see no changes on the system:

    bin/papply.sh

**NOTE:** you need at least 4Gb of RAM to run on the same node `Puppet Server` and `PuppetDB` (with the `PostgreSQL` backend).
