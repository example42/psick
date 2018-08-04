
- [example42 PSICK Puppet Open Source Server automation](#example42-psick-puppet-open-source-server-automation)
    - [1. Vagrant installation](#1-vagrant-installation)
        - [Prerequisites](#prerequisites)
        - [Procedure](#procedure)
    - [2. Base OS installation](#2-base-os-installation)
        - [Prerequisites](#prerequisites-1)
        - [Procedure](#procedure-1)

## example42 PSICK Puppet Open Source Server automation

This `control-repo` allows to spin up a `Puppet Open Source Server` in a fully automated way.

One can use [vagrant](https://www.vagrantup.com/) or even use `PSICK` on a fresh base OS installation.


### 1. Vagrant installation

#### Prerequisites

  - `Vagrant`
  - local `ruby` installation. Best option is to use [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv)
  - root rights
  - `puppet-agent` and `r10k` packages installed


#### Procedure

Install either [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv). Then run:

```
    bundle install --path vendor/bundle
```

Use ```bundle``` to install the modules via ```r10k``` from ```Puppetfile```:

```
    bundle exec r10k puppetfile install -v
```

Now change to ```vagrant/environments/foss``` directory and start up `Vagrant` machine.

```
    cd vagrant/environments/foss
    vagrant up puppet.foss.psick.io
```

### 2. Base OS installation

#### Prerequisites

  - at least 4 GB of RAM to run `Puppet Server` and `PuppetDB` (with the `PostgreSQL` backend) on the same node
  - compatible OS (tested on ```RedHat 7``` derivatives and ```Ubuntu 16.04```)
  - root rights
  - `puppet-agent` and `r10k` packages installed


#### Procedure

The easiest way to install the `FOSS Puppet Server` with `PuppetDB` on a vanilla OS is to clone `control-repo` into ```/etc/puppetlabs/code/environments/production``` folder and apply the **```puppet_foss_master```** `role`:

```
    sudo -s
 
    mkdir -p /etc/puppetlabs/code/environments
    cd /etc/puppetlabs/code/environments
    git clone https://github.com/example42/psick.git production
    cd production

    PSICK_DIR=$(git rev-parse --show-toplevel)
```

At this point, from `PSICK` base directory we will install `Puppet 5 agent`:

```
    cd $PSICK_DIR
    bin/puppet_install.sh
```

After that, install `r10k` (and other recommended gems) and populate the `modules/` directory with the content defined in the ```Puppetfile``` in an **unattended way**:

```    
    bin/puppet_setup.sh auto
```

**NOTE:** Ignore **warnings** about missing ```docker```, ```vagrant``` and ```fab``` commands.

Next, assign the **```puppet_foss_master```** `role` to the node, by setting the `role` as [external fact](external_facts.md):

```
    bin/puppet_set_external_facts.sh --role puppet_foss_master
```

Finally, to setup a `Puppet Server` with `PuppetDB` locally, via `Puppet` just run:

```
    bin/papply.sh
```

 **NOTE:** If you have errors at the first run (known ones are related to the used `Postgresql module`) run the command again, until you see no changes on the system:

```
    bin/papply.sh
```
