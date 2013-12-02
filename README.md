# EXAMPLE42 PUPPET MODULES

Released under the terms of Apache2 licence.

Copyright Alessandro Franceschi / Lab42 (and specific commits authors)

Official website: [http://www.example42.com](http://www.example42.com)

Official Support forum: [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules)


## IMPORTANT NOTICE:

Example42 modules have been delevoped over the years following Puppet's evolution.

There are currently 3 generations of example42 modules:

* "OLD" modules (Version 1.x) are no more supported or recommended.
  They are supposed to work also on Puppet versions before 2.6
  You can give them a look using the 1.0 branch of this repo.

* "NextGen" modules (Version 2.x) are currently the most used and recommended.
  They are compatible only with Puppet version 2.6 and later.
  You find them here as git submodules.

* "StdMod" modules (Version 3.x) are the next evolution of Example42 modules.
  They are going to adhere to StdMod naming standards and be compatible with Puppet > 2.7 or 3.x
  They are currently under development and testing, you find them here as git submodules


## INSTALLATION

You can retrieve the Example42 modules Version 1.0 ("OLD") with:

    git clone --recursive -b 1.0 git://github.com/example42/puppet-modules.git

You can get the current module set, with both NextGen and StdMod modules with:

    git clone --recursive git://github.com/example42/puppet-modules.git

You can use the [Puppet Playground](https://github.com/example42/puppet-playground) to test these (and other) modules on a safe Vagrant environment.

From September 2013 most of the modules are published, and regularly updated, on the **Puppet Forge**.

Use the Puppet module tool to query and install Example42 modules:

        puppet module search example42

## UPDATE

When you want to update the modules with the upstream version remember that also the submodules have to be updated:

    cd /etc/puppet/modules # Or the dir where you have your local git repo

    git pull origin master
    git submodule init
    git submodule update

If you want to force an update on each submodule, even if not tracked on the main repo:

    git submodule foreach git pull origin master

The above commands (excluded the first cd and included the last) are done by the script:

    Example42-tools/sync.sh

** DO NOT UPDATE IN PRODUCTION !!! **
To preserve freedom to reorganize modules and keep them updated this repo is going to keep track of the most current versions of the various modules. This can introduce backwards incompatibilities when a module is converted to the new major version (for example when 1.x have been completely removed or 2.x modules are converted to 3.x).



## DEPENDENCIES

All the modules have a Modulefile where dependencies are described.

All the NextGen module **require** the presence in the $modulepath of the '**puppi**' module, but you are not required to use Puppi (the dependency is for some extra functions prresent in the puppi module, which can be used even without including puppi in your manifests).

The StdMod modules require PuppetLabs' stdlib.

Most of the modules have a limited set of dependencies and, in some cases, you can pass a specific option (install_dependencies => false) to skip the inclusion of dependent classes from the Example42 set (in these cases you are supposed to provide the same resources in other ways).

If you enable the monitor or firewall options you have to include the relevant modules: respectively, monitor + the used monitor tool and firewall + iptables.


## OPERATING SYSTEMS SUPPORT

Currently most of the modules are tested on the following Operating systems:

* RedHat / Centos versions 5 and 6

* Scientific Linux version 6

* Debian 6 and 7

* Ubuntu 10.04 and 12.04


Some of the modules have support for:

* OpenSuse 11 and 12

* Suse Enterprise Linux 11

* Solaris 11


Most of the modules are expected to work on:

* Amazon Linux 3

* Fedora

* Mint


If you need support or better testing for specific operating systems and versions the best thing you can do is to provide an usable Vagrant Base box for the [Example42 Puppet Playground](https://github.com/example42/puppet-playground). 

## CONTRIBUTE

**Pull requests** via GitHub are welcomed, please review the general style and logic of the modules in order to submit consistent patches. These modules are intended to be used anywhere **without any modification** of their content: if you have to change them to suit your needs either they have some bugs or missing features or you're using them in the wrong way.

Please provide patches puppet-lint compliant and, where possible, provide rspec unit tests.

If you have a module not present in this set based on the Example42 templates, feel free to provide a a link to its repo url, we can add it as submodule.


## DIFFERENCES BETWEEN VERSIONS

2.x modules are compatible only with Puppet versions > 2.6.

They are also compliant with Puppet 3.0, when dynamic variables scoping is going to be be discontinued.

These modules can be used with the "set variables and include the class" pattern or can be used as parametrized classes.

The main difference for the first approach is that only top scope variables can be used (so either set them in a ENC or use tools like Hiera to give them the values you need according to custom conditions).

2.x modules allow much cleaner and separated customizations so that you hardly need to modify them in order to add custom resources or redefine existing ones.

Decommissioning of classes is now done via top scope variables or arguments of the main class (absent, disable, disableboot) and not including the relevant sub-class.

Monitoring and firewalling abstraction and Puppi integration are still present, while backup abstraction has been discontinued.

3.x modules have these differences:

 - params_lookup function is removed, use Puppet 3 data bindings to data input alternatives

 - some parameters names are changed, according to stdmod namings



Modules code, issue tracking and features requests are on [GitHub](https://github.com/example42)

For questions, suggestions and general discussion use the [Example42 Puppet Modules Google group](https://groups.google.com/forum/#!forum/example42-puppet-modules)

If you need a specific module, improvements or conversion to 3.x of an existing one consider the possibility to [sponsor it](http://example42.com/?q=sponsor_Example42_modules_development)


Alessandro Franceschi
Lab42


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/example42/puppet-modules/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

