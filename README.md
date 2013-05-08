# EXAMPLE42 PUPPET MODULES

Released under the terms of Apache2 licence.

Copyright Alessandro Franceschi / Lab42 (and specific commits authors)

Official website: [http://www.example42.com](http://www.example42.com)

Official Support forum: [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules)


## IMPORTANT NOTICE:

The Puppet modules provided in this repository are from 2 different generations:

* "OLD" modules are the ones you see as plain directories under this repo.
  They are supposed to work also on Puppet versions before 2.6

* "NEW" (or "**NextGen**") modules are managed as git submodules of this repo.
  They are compatible only with Puppet version 2.6 and later.

Old modules are going to be replaced with new ones following a "**Job Driven Development**" approach (I update them when I need to use them for customers).

Usage of old and new modules is rather different and, generally, I recommend the usage of NextGen only modules.

You can get a "pure" NextGen repository [here](https://github.com/example42/puppet-modules-nextgen).

The whole Old gen set of modules is kept under the 1.0 branch. This is not mantained any more.


## INSTALLATION

You can retrieve the Example42 modules Version 1.0 ("OLD") with:

    git clone --recursive -b 1.0 git://github.com/example42/puppet-modules.git

You can get the current module set, with both 1.0 and NextGen modules with:

    git clone --recursive git://github.com/example42/puppet-modules.git

You can use the [Puppet Playground](https://github.com/example42/puppet-playground) to test these (and other) modules on a safe Vagrant environment.


## UPDATE

When you want to update the modules with the upstream version (don't do this directory in a production environment!) remember that also the submodules have to be updated:

    cd /etc/puppet/modules # Or the dir where you have your local git repo

    git pull origin master
    git submodule init
    git submodule update

If you want to force an update on each submodule, even if not tracked on the main repo:

    git submodule foreach git pull origin master

The above commands (excluded the first cd and included the last) are done by the script:

    Example42-tools/sync.sh


## DEPENDENCIES

All the modules have a Modulefile where dependencies are described.

All the NextGen module **require** the presence in the $modulepath of the '**puppi**' module, but you are not required to use Puppi (the dependency is for some extra functions prresent in the puppi module, which can be used even without including puppi in your manifests).

Some of the OldGen modules require the 'common' module, which is going to be discontinued.

Most of the modules have a limited set of dependencies and, in some cases, you can pass a specific option (install_dependencies => false) to skip the inclusion of dependent classes from the Example42 set (in these cases you are supposed to provide the same resources in other ways).

If you enable the monitor or firewall options you have to include the relevant modules: respectively, monitor + the used monitor tool and firewall + iptables.


## OPERATING SYSTEMS SUPPORT

Currently most of the modules are tested on the following Operating systems:

* RedHat / Centos versions 5 and 6

* Scientific Linux version 6

* Debian 6

* Ubuntu 10.04 and 12.04


Some of the modules have support for:

* OpenSuse 11 and 12

* Suse Enterprise Linux 11

* Solaris 11


Most of the modules are expected to work on:

* Amazon Linux

* Fedora

* Mint


If you need support or better testing for specific operating systems and versions the best thing you can do is to provide an usable Vagrant Base box for the [Example42 Puppet Playground](https://github.com/example42/puppet-playground). 

## CONTRIBUTE

**Pull requests** via GitHub are welcomed, please review the general style and logic of the modules in order to submit consistent patches. These modules are intended to be used anywhere **without any modification** of their content: if you have to change them to suit your needs either they have some bugs or missing features or you're using them in the wrong way.


## DIFFERENCES BETWEEN OLD AND NEW MODULES

The new modules are compatible only with Puppet versions > 2.6.

They are also compliant with Puppet 3.0, when dynamic variables scoping is going to be be discontinued.

The new modules can be used as the old ones, "set variables and include the class" or can be used as parametrized classes.

The main difference for the first approach is that only top scope variables can be used (so either set them in a ENC or use tools like Hiera to give them the values you need according to custom conditions).

The new modules allow much cleaner and separated customizations so that you hardly need to modify them in order to add custom resources or redefine existing ones.

Decommissioning of classes is now done via top scope variables or arguments of the main class (absent, disable, disableboot) and not including the relevant sub-class.

Monitoring and firewalling abstraction and Puppi integration are still present, while backup abstraction has been discontinued.

The new modules use an alternative approach to Puppi integration.

The Puppi module is going to remain unique and compatible for both the old and the new modules, at least until the migration has been completed.

For any question contact me via GitHub or on http://www.example42.com

Alessandro Franceschi

Lab42
