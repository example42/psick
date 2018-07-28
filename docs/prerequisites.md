- [Prerequisites](#prerequisites)
    - [Single Modules](#single-modules)
    - [Control repo](#control-repo)
    - [Vagrant](#vagrant)
    - [Docker](#docker)

## Prerequisites

To have a fully working environment we might need to locally install some software for specific activities.

We can simply run ```bin/setup.sh``` to install them via `Puppet` or just can do that manually, as follows.

### Single Modules

All the modules have a ```metadata.json``` file where dependencies are described.

Most of the modules require `PuppetLabs' stdlib`.

### Control repo

To be able to use the `control-repo` with `Puppet` some gems are needed and modules defined in the ```Puppetfile``` have to be deployed.

The `hiera-eyaml`, `r10k` and `deep_merge` gems can be installed by the setup script or manually with commands like:

    # Gem installation in system
    gem install hiera-eyaml
    gem install r10k
    gem install deep_merge

    # Gem installation in Puppet environment
    /opt/puppetlabs/puppet/bin/gem install hiera-eyaml
    /opt/puppetlabs/puppet/bin/gem install r10k
    /opt/puppetlabs/puppet/bin/gem install deep_merge

    # Gem installation in Puppet server environment (if present)
    /opt/puppetlabs/bin/puppetserver gem install hiera-eyaml
    /opt/puppetlabs/bin/puppetserver gem install r10k
    /opt/puppetlabs/bin/puppetserver gem install deep_merge

Population of the ```modules``` directory via ```r10k``` based on ```Puppetfile```:

    r10k puppetfile install -v

The above steps can be accomplished by simply running ```bin/puppet_setup.sh```.


### Vagrant

For a correct setup of the `Vagrant` environment we need `Vagrant`, `VirtualBox` and some extra plugins:

    vagrant plugin install vagrant-cachier
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-hostmanager

These plugins, as `Vagrant` itself, can be installed by the ```bin/setup.sh``` script.

### Docker

`Docker` operations via `Fabric` or the command line require `Docker` to be locally installed.

If we use `Mac` or `Windows` we need the newer native client, things won't work when using `Docker` running inside a `Virtualbox VM`.

You'll need to run ```docker login``` before trying any operation that involves pushing our images to `Docker registry`.

Also `Docker` can be installed by the ```bin/setup.sh``` script.
