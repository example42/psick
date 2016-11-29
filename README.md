# example42 Puppet control-repo

A state of the art, feature rich, Puppet 4 control-repo. Use it to:

  - Explore the layout of a modern, opinionated, general purpose, control-repo
  - Create and use Puppet 4 optimised modules with updated design patterns
  - Test your code in the Docker and Vagrant environments
  - Fork and use as starting point for your Puppet infrastructure
  - Manage the deployment workflow of your Puppet code


## Installation

Download this repository:

    git clone https://github.com/example42/control-repo
    cd control-repo

To install the minimum prequequisites (hiera-eyaml, deep_merge, r10k gems) and populate the external modules directory via r10k, just run: 

    bin/puppet_setup.sh

If you also want to install the recommended (Fabric, Vagrant, Docker) tools that can be used with the repo, run:

    bin/setup.sh

You will be asked to confirm or skip each component installation.

NOTE: setup.sh currently does not fully work on Mac and Windows.

For unattended setups (typically in CI pipelines) you can skip confirmation requests with:

    bin/setup.sh auto


## Documentation

The control-repo is full of more or less hidden stuff, which ease a lot Puppet code development, testing and deployment.

For more information on specific topics:

  - [Development Workflow](docs/workflow.md) - An introduction of possible commands and workflows for Puppet code management

  - [Vagrant Integration](docs/vagrant.md) - How to use Vagrant to test the control-repo while deployment

  - [Docker Integration](docs/docker.md) - How to use Docker to test Puppet code and to build images based on the existing Puppet code

  - [AWS Integration](docs/aws.md) - How to use Puppet to query and configure AWS resources from the control-repo

  - [Noop Mode](docs/noop_mode.md) - An overview on how to enforce noop mode server side with this repo

  - [Trusted Facts](docs/trusted_facts.md) - How to set and use trusted facts in this control-repo

  - [Hiera eyaml](docs/hiera_eyaml.md) - An overview on how to use hiera-eyaml

  - [Git tasks](docs/git.md) - A review of Git tasks available with Fabric

  - [Puppet tasks](docs/puppet.md) - A review of Puppet tasks available with Fabric

  - [Tiny Puppet Integrations](docs/tp.md) - Learn about the impressive things you can do with Tiny Puppet and this control-repo

  - [example42 history](docs/example42.md) - A summary of the evolution of example42 modules


## Common tasks via Fabric

Many useful and common activities related to Puppet code development, testing and deployment can be fulfilled using Fabric.

Many Fabric tasks use scripts in the ```bin/``` directory. You can invoke them directly, if preferred.

Show available Fabric tasks (note: some will be run locally, some on the hosts specified via -H):

    fab -l

Run a Fabric task (better to do this from the main repo directory):

    fab <task>[:host=<hostname>][,option=value]


## Dependencies

To have a full working environment you might need to locally install some software for specific activities.

You can simply run ```bin/setup.sh``` to install them via Puppet or just can do that manually, as follows.

### Single Modules

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

    # Gem installation in Puppet server environment (if present)
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

### Docker

Docker operations via Fabric or the command line require Docker to be locally installed.

If you use Mac or Windows you need the newer native client, things won't work when using Docker running inside a Virtualbox VM.

You'll need to run ```docker login``` before trying any operation that involves pushing your images to Docker registry.

Also Docker can be installed by the setup script.


## Using and understanding this control-repo

The control-repo you find here is what we consider a starting point for a state of the art general purpose Puppet setup.

It's based on a nodeless classification, driven by 3 top scope variables:

  - ```$::role``` - Defines the nodes' role
  - ```$::env``` - Defines the nodes' operational environment
  - ```$::zone``` - Defines the datacenter or region or segment of an infrastructure (optional)

These variables are used in the Hiera's hierarchy (check ```hiera.yaml```) and should be enough to classify univocally any node in a averagely complex infrastructure. Here they are set as external facts (you'll need to set them when provisioning your nodes, as it's done in the Vagrant environment).

Such an approach can be easily adapted to any other logic and environment, for example, you can use an External Node Classifier (ENC) like Puppet Enterprise or The Foreman and manage there how your nodes are classified.

The manifests file, ```manifests/site.pp``` sets some resource defaults, includes a baseline profile according to the underlying OS and uses hiera to define what profiles have to be included in each role (a more traditional alternative, based on role classes, is possible).

All the Hiera data is in ```hieradata``` , the file ```hiera.yaml``` shows a possible hierarchy design and uses ```hiera-eyaml``` as backend for keys encryption (no key is currently encrypted, because we are not shipping the generated private key (it's in .gitignore).
You will have to regenerate your hiera-eyaml keys (run, from the main repo dir, ```eyaml createkeys```).

In the ```site``` directory there are local "not public" modules. Basically our profiles and some role examples.

For specifically there's the **profile** modules under ```site/profile``` with a large amount of sample profiles for several common and not so sommon tasks.

There's also a **tools** module, under ```site/tools``` which contains defines useful to manage common resources on a system.

In the ```modules``` directory are placed the public modules, as defined in the ```Puppetfile``` and installed via r10k or librarian-puppet.

The ```vagrant``` directory contains different Vagrant environments with the relevant toolset that can be used to test the same control-repo.
They are fully customizable by editing the ```config.yaml``` file in each Vagrant environment.

Files for building Docker images locally are under the ```docker``` directory.

The ```skeleton``` directory contains a module skeleton you can use, and modify, to generate new modules based on the skeleton structure.
 
Documentation is stored under ```docs```, while the ```bin``` directory contains several scirpts fot various purposes. Most of them can be invoked via Fabric, as configured in the ```*.py``` files in the main directory.


