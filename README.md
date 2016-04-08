# EXAMPLE42 PUPPET MODULES

Released under the terms of Apache2 licence.

Copyright example42 GmbH (and specific commits authors)

Official website: [http://www.example42.com](http://www.example42.com)

Official Support forum: [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules)


## Example42 modules evolution

Example42 modules have been delevoped over the years following Puppet's evolution.

There are currently 4 generations of example42 modules:

* "OLD" modules (Version 1.x) are no more supported or recommended.
  They are supposed to work also on Puppet versions before 2.6
  You can give them a look using the 1.0 branch of this repo.

* "NextGen" modules (Version 2.x) are currently the most used and recommended.
  They are compatible only with Puppet version 2.6 and later.
  You find them here as git submodules.

* "StdMod" modules (Version 3.x) were supposed to be the next evolution of Example42 modules.
  They adhere to StdMod naming standards and be compatible with Puppet > 2.7 or 3.x
  This is an half baked generation, which was abandoned for other projects.

* Version 4.x modules. Many modules have been deprecated and not maintained anymore.
  We will care better about the remaining ones. They are supposed to be Puppet 4 compliant.
  The structure of the repo hash changed, all the git submodules have been removed and a
  control-repo setup has been introduced.

## INSTALLATION

Use the Forge to install example42 modules:

    puppet modules search example42 # Note that many are now deprecated

or cherry pick them from [GitHub](https://github.com/example42).

You have here a control-repo using all the Example42 supported modules and third party ones:

    git clone git://github.com/example42/puppet-modules.git

You can retrieve the Example42 modules from other versions with:

    git clone --recursive -b 1.0 git://github.com/example42/puppet-modules.git
    git clone --recursive -b 2.0 git://github.com/example42/puppet-modules.git
    git clone --recursive -b 3.0 git://github.com/example42/puppet-modules.git


## Dependencies

All the modules have a metadata.json file where dependencies are described.

Most of the modules require PuppetLabs' stdlib.
Some modules (the ones which use the ```params_lookup``` function) require Puppi.


