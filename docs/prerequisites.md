## Prerequisites

To have a full working environment you might need to locally install some software for specific activities.

You can simply run ```bin/setup.sh``` to install them via Puppet or just can do that manually, as follows.

### Single Modules

All the modules have a ```metadata.json``` file where dependencies are described.

Most of the modules require PuppetLabs' stdlib.
Some modules (the ones, of generation 2.x, which use the ```params_lookup``` function) require Puppi.

### Control repo

To be able to use the control-repo with Puppet some gems are needed and modules defined in the ```Puppetfile``` have to be deployed.

The hiera-eyaml, r10k and deep_merge gems can be installed by the setup script or manually with commands like:

    # Gem installation in system
    gem install hiera-eyaml
    gem install r10k
    gem install deep_merge

    # Gem installation in Puppet environment
    /opt/puppetlabs/puppet/bin/gem install hiera-eyaml
    /opt/puppetlabs/puppet/bin/gem install r10k
    /opt/puppetlabs/puppet/bin/gem install deep_merge

    # Gem installation in Puppet server environment (if present)
    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install hiera-eyaml
    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install r10k
    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install deep_merge

Population of the ```modules``` directory via r10k based on ```Puppetfile```:

    r10k puppetfile install -v

The above steps can be accomplished by simply running ```bin/puppet_setup.sh```.


### Vagrant

For a correct setup of the Vagrant environment you need Vagrant, VirtualBox and some extra plugins:

    vagrant plugin install vagrant-cachier
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-hostmanager

These plugins, as Vagrant itself, can be installed by the setup script.

### Docker

Docker operations via Fabric or the command line require Docker to be locally installed.

If you use Mac or Windows you need the newer native client, things won't work when using Docker running inside a Virtualbox VM.

You'll need to run ```docker login``` before trying any operation that involves pushing your images to Docker registry.

Also Docker can be installed by the setup script.


