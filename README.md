# EXAMPLE42 PUPPET MODULES

Released under the terms of Apache2 licence.

Copyright example42 GmbH (and specific commits authors)

Official website: [http://www.example42.com](http://www.example42.com)

Official Support forum: [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules)


## Example42 modules evolution

There are currently 4 generations of example42 modules:

* "OLD" modules (Version 1.x) are no more supported or recommended.
  They are supposed to work also on Puppet versions before 2.6
  You can give them a look using the 1.0 branch of this repo.

* "NextGen" modules (Version 2.x) were made before the release of Puppet 3.
  They are compatible with Puppet version 2.6 , 3 and, for most, 4.
  You find them linked as git submodules.

* "StdMod" modules (Version 3.x) were supposed to be the next evolution of Example42 modules.
  They adhere to StdMod naming standards and be compatible with Puppet > 2.7 or 3.x
  This is an half baked generation, which was abandoned for other projects.

* Version 4.x modules. Many modules have been deprecated and not maintained anymore.
  We will care better about the remaining ones. They are expected to be Puppet 4 compliant.
  The structure of the repo has changed radically, all the git submodules have been removed and a
  control-repo style has been introduced.

## Installation

Use the Forge to install example42 modules (be aware of the deprecated ones):

    puppet modules search example42

or cherry pick them from [GitHub](https://github.com/example42).

You have here a control-repo, with embedded Vagrant environment, that includes all the example42 supported modules and a few third party ones. You can use this for:

  - Play with Vagrant and Puppet
  - Test example42 modules
  - Use as a starting point for a custom controlrepo

Installation from GitHub:

    git clone git://github.com/example42/puppet-modules.git
    r10k puppetfile install
    vagrant status


You can retrieve the Example42 modules from other versions with:

    git clone --recursive -b 1.0 git://github.com/example42/puppet-modules.git
    git clone --recursive -b 2.0 git://github.com/example42/puppet-modules.git
    git clone --recursive -b 3.0 git://github.com/example42/puppet-modules.git


## Dependencies

### Modules

All the modules have a metadata.json file where dependencies are described.

Most of the modules require PuppetLabs' stdlib.
Some modules (the ones which use the ```params_lookup``` function) require Puppi.

### Vagrant

For a correct setup of the Vagrant environment you need some extra plugins:

    vagrant plugin install vagrant-cachier
    vagrant plugin install vagrant-vbguest



