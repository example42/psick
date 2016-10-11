# example42 Puppet control-repo

A state of the art, feature rich, Puppet 4 control-repo where you can:

  - Explore the layout of a modern, general purpose, control-repo 
  - Create and use Puppet 4 optimised modules with updated design patterns
  - Test your code in the Docker and Vagrant environments
  - Fork a clone as starting point for your Puppet infrastructure

Released under the terms of Apache2 licence.

Copyright example42 GmbH (and specific commits authors)

Code: [https://github.com/example42/control-repo](https://github.com/example42/control-repo)

Official website: [http://www.example42.com](http://www.example42.com)

Official Support forum: [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules)


## Installation

Download this repository:

    git clone https://github.com/example42/control-repo
    cd control-repo

To setup or verify the presence of the needed prerequisites just execute the script:

    bin/puppet_setup.sh

If you have Fabric installed local you can use Fabric for initial setup (and many other operations):

    fab puppet.setup
    
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

  - [example42 history](docs/example42.md) - A summary of the evolution of example42 modules


## Common tasks via Fabric

Many useful and common activities related to Puppet code development, testing and deployment can be fulfilled using Fabric. Many Fabric tasks use shell commands and scripts you can invoke directly, if preferred.

Show available Fabric tasks (note: some will be run locally, some on the hosts specified via -H):

    fab -l

Run a Fabric task (better to do this from the main repo directory):

    fab <task>[:host=<hostname>][,option=value]


## Dependencies

To have a full working environment you might need to locally install some software for specific activities.


### Single Modules

All the modules have a ```metadata.json``` file where dependencies are described.

Most of the modules require PuppetLabs' stdlib.
Some modules (the ones, of generation 2.x, which use the ```params_lookup``` function) require Puppi.

### Control repo

The modules used (and some example42 other)  in this control repo are defined in the ```Puppetfile``` and can be installed manually via git, from the Forge or via r10k.

To install r10k:

    gem install r10k

To install Fabric you can use the local package providers or pip (you might need to install also the ecdsa package):

    pip install fabric
    pip install ecdsa

### Vagrant

For a correct setup of the Vagrant environment you need some extra plugins:

    vagrant plugin install vagrant-cachier
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-hostmanager

### Docker

Docker operations via Fabric or using the command line require Docker to be locally installed.

If you use Mac or Windows you need the newer native client, things won't work when using Docker running inside a Virtualbox VM.

You'll need to run ```docker login``` before trying any operation that involves pushing your images to Docker registry.


## Using and understanding this control-repo

The control-repo you find here is what we consider a starting point for a state of the art general purpose Puppet setup.

It's based on a nodeless classification, driven by 3 top scope variables:

  - ```$::role``` - Defines the nodes' role
  - ```$::env``` - Defines the nodes' operational environment
  - ```$::zone``` - Defines the datacenter or region or segment of an infrastructure (optional)

These variables are used in the Hiera's hierarchy (check ```hiera.yaml```) and should be enough to classify univocally any node in a averagely complex infrastructure. Here they are set as external facts (you'll need to set them when provisioning your nodes, as it's done in the Vagrant environment).

The manifests file, ```manifests/site.pp``` sets some resource defaults, includes a baseline profile according to the underlying OS and uses hiera to define what profiles have to be included in each role (a more traditional alternative, based on role classes, is possible).

All the Hiera data is in ```hieradata``` , the file ```hiera.yaml``` shows a possible hierarchy design and uses ```hiera-eyaml``` as backend for keys encryption (no key is currently encrypted, because we are not shipping the generated private key (it's in .gitignore).
You will have to regenerate your hiera-eyaml keys (run, from the main repo dir, ```eyaml createkeys```).

In the ```site``` directory there are local "not public" modules. Basically our profiles and some role examples.

In the ```modules``` directory are placed the public modules, as defined in the ```Puppetfile``` and installed via r10k or librarian-puppet.

The ```vagrant``` directory contains different Vagrant environments with the relevant toolset that can be used to test the same control-repo.
They are fully customizable by editing the ```config.yaml``` file.

The ```skeleton``` directory contains a module skeleton you can use, and modify, to generate new modules based on the skeleton structure.
 
