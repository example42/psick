# example42 Puppet modules

A state of the art Puppet 4 control-repo with a selection of modules.

Use it to test the latest Puppet technologies (via the embedded Vagrant environments),
as starting point for new projects or as a reference on how to organise your Puppet code and data.

Released under the terms of Apache2 licence.

Copyright example42 GmbH (and specific commits authors)

Official website: [http://www.example42.com](http://www.example42.com)

Official Support forum: [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules)



## Installation

Use the Forge to install single example42 modules (be aware of the deprecated or old (2.x) ones):

    puppet module search example42

or cherry pick them from [GitHub](https://github.com/example42).

### Control-repo setup from GitHub:

    git clone git://github.com/example42/puppet-modules.git
    cd puppet-modules
    r10k puppetfile install -v
    
    # For testing move in one of the vagrant environments:
    cd vagrant/environments/puppetinfra
    vagrant status

    # To customize the vagrant environment:
    vi config.yaml

### Old versions installation

You can retrieve the Example42 modules from other versions with:

    git clone --recursive -b 1.0 git://github.com/example42/puppet-modules.git
    git clone --recursive -b 2.0 git://github.com/example42/puppet-modules.git
    git clone --recursive -b 3.0 git://github.com/example42/puppet-modules.git

Note that earlier versions were based on git modules.


## Dependencies

### Single Modules

All the modules have a ```metadata.json``` file where dependencies are described.

Most of the modules require PuppetLabs' stdlib.
Some modules (the ones, of generation 2.x, which use the ```params_lookup``` function) require Puppi.

### Control repo

The modules used (and some example42 other)  in this control repo are defined in the ```Puppetfile``` and can be installed manually via git, from the Forge or via r10k.

### Vagrant

For a correct setup of the Vagrant environment you need some extra plugins:

    vagrant plugin install vagrant-cachier
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-hostmanager


## Example42 modules evolution

There are currently 4 generations of example42 modules:

* "OLD" modules (Version 1.x) are no more supported or recommended.
  They are supposed to work also on Puppet versions 0.x
  You can give them a look using the 1.0 branch of this repo.

* "NextGen" modules (Version 2.x) were made before the release of Puppet 3.
  They are compatible with Puppet version 2.6 , 3 and, for most, 4.
  You find them linked as git submodules.

* "StdMod" modules (Version 3.x) were supposed to be the next evolution of Example42 modules.
  They adhere to StdMod naming standards and be compatible with Puppet > 2.7 or 3.x
  This is an half baked generation, which was abandoned for other projects.

* Version 4.x modules. Many modules have been deprecated and not maintained anymore.
  They are expected to be Puppet 4 only compliant.
  The structure of the repo has changed radically, all the git submodules have been removed and a
  control-repo style has been introduced.
  Currently the repo mantains also modules not optimised for Puppet 4, they will be upgraded or deprecated.



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
The one in ```vagrant/environments/puppetinfra``` is fully customizable by editing the ```config.yaml``` file. 
