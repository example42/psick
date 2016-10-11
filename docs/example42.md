# example42 Puppet control-repo and modules

## Example42 modules evolution

There are currently 4 generations of example42 modules:

* "OLD" modules (Version 1.x) are no more supported or recommended.
  They are supposed to work also on Puppet versions 0.x.
  You can give them a look using the 1.0 branch of this repo.

* "NextGen" modules (Version 2.x) were made before the release of Puppet 3.
  They are compatible with Puppet version 2.6 , 3 and, for most, 4.
  They were linked as git submodules.

* "StdMod" modules (Version 3.x) were supposed to be the next evolution of Example42 modules.
  They adhere to StdMod naming standards and be compatible with Puppet > 2.7 or 3.x
  This is an half baked generation, which was abandoned for other projects.

* Version 4.x modules. Most of the old pre-Puppet 4 modules have been deprecated and not maintained anymore.
  They are Puppet 4 only compliant.
  The structure of the repo has changed radically, all the git submodules have been removed and a
  control-repo style has been introduced.
  With the release of 4.x this repo has been renamed: from **puppet-modules** to **control-repo**.

    
## Installing single example42 Puppet modules

Use the Forge to install single example42 modules (be aware of the deprecated or old (2.x) ones):

    puppet module search example42

or cherry pick them from [GitHub](https://github.com/example42).

Note that most of example42 modules are not obsolete and no more actively maintained.

Most of their functionality is reproduced by Tiny Puppet or by the profiles in this control-repo.

### Old versions installation

You can retrieve the old lists of Example42 modules from other versions with:

    git clone --recursive -b 1.0 git://github.com/example42/control-repo.git
    git clone --recursive -b 2.0 git://github.com/example42/control-repo.git
    git clone --recursive -b 3.0 git://github.com/example42/control-repo.git

Note that earlier versions are based on git modules and have not a control-repo structure.


### Single Modules

All the modules have a ```metadata.json``` file where dependencies are described.

Most of the modules require PuppetLabs' stdlib.
Some modules (the ones, of generation 2.x, which use the ```params_lookup``` function) require Puppi.

