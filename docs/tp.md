- [example42 control-repo and Tiny Puppet](#example42-control-repo-and-tiny-puppet)
    - [PSICK tp profiles](#psick-tp-profiles)
    - [tp in component modules](#tp-in-component-modules)
    - [Install anything anywhere with a tiny command](#install-anything-anywhere-with-a-tiny-command)
    - [Create tiny data for a new application](#create-tiny-data-for-a-new-application)
    - [Local or remote integration tests (WIP)](#local-or-remote-integration-tests-wip)

## example42 control-repo and Tiny Puppet

This `Puppet` `contro-repo` has various interesting integrations with [Tiny Puppet](http://tiny-puppet.com), even if they are totally optional, we strongly recommend to give ```tp``` a try: it can save you a lot of time.

Integration with `Tiny Puppet` ([tp](https://github.com/example42/puppet-tp)) and [tinydata](https://github.com/example42/tinydata) modules (they are both present in the ```Puppetfile```) is at different levels:

  - Several sample profiles of this `control-repo` use `tp defines` to manage the relevant applications

  - Some (currently experimental) external modules use `tp` in module, with local data

  - It's possible to easily install any (known) app locally, via a `tp shell` wrapper

  - It's possible to quickly create data for new apps to manage

  - Integration tests comes out of the box free, for multiple apps and os, with ```tp::test```

### PSICK tp profiles

The `psick module` contains standard profiles for different applications based on `Tiny Puppet`. They can be found in ```modules/psick/manifests/$application/tp```. You are free to use them or not and they can be good examples on how to design profiles based on ```tp``` and save headaches and time on studying and integrating a dedicated component module.

### tp in component modules

Some experimental modules (`apache v4.x`, `docker`, `rails`, `ansible...`) added by default in the ```Puppetfile``` use ```tp``` directly in the module, with local ```tp data```, to manage the component application.

For more info on this usage of ```tp``` inside component modules and other modern design patterns for modules, read this [blog post](http://www.example42.com/2016/05/30/exploring-puppet4-modules-design-patterns/).

### Install anything anywhere with a tiny command

Imagine a simple command, it expects as input the name of an application or a software and installs it. It takes care automatically of:

  - installing the eventual repositories that provide the package

  - use the right package name for the underlying operating systems

  - if it depends on other software or packages, install them as prerequisites

A command like ```install <software>``` that works everywhere, with any software that can be installed via a package.

Well, it exists. Here. But it's called ```tp_install.sh```.

To install locally (you might need ```root``` privileges ) *any application on any operating system*, managing all the necessary dependencies, just write from the main dir of this `control-repo`:

    bin/tp_install.sh <app_name>

Or if you prefer to run it via `Fabric:`

    fab tp.install:<app_name>

Prerequisites for the magic to happen:

  - `Puppet 4` or later must be installed locally. To do it from the `control-repo:`

        bin/puppet_install.sh [redhatX|debian|ubuntu] # WIP on automatic OS detection

  - This `control-repo` is provisioned locally (that is it has run `r10k` to fetch `tp` and `tinydata` modules from upstream source). You can do it with:

        bin/puppet_setup.sh

    or, simply, have `tp` installed via:

        puppet module install example42/tp

  - There's in `tinydata` all the needed data to install your application on your OS.


Some possible uses:

    # Setup epel (on RHEL systems)
    bin/tp_install.sh epel

    # Install sysdig (automatically manages dependencies from other tp apps)
    # Requires tp version >= 1.2 and tinydata version >= v0.0.14 )
    bin/tp_install.sh sysdig

    # Install puppetserver from Puppet official repos
    bin/tp_install.sh puppetserver

    # Install docker from Docker official repos
    bin/tp_install.sh docker-engine

    # Install virtualbox from Oracle official repos
    bin/tp_install.sh virtualbox

    # Install OpenJDK
    bin/tp_install.sh openjdk-jdk

    # Install apache for the lazy or mindless ones
    bin/tp_install.sh apache

If some of these or other commands don't work for the selected app on your local operating system, then it's probably a matter of missing or wrong ```tinydata```, which can be easily solved.

Current support for most of the applications in `tinydata` is for `Linux` (mostly `RedHat` and `Debian` derivatives). `MacOS` and `Windows` support is technically present, but data is missing for most of the cases. Support is possible for any OS for which there's a Puppet package provider.


### Create tiny data for a new application

To replicate the structure of the ```tinydata``` directory of an existing application and create data for a **new** app:

    fab tp.clone_data:redis

`redis`, or whatever you specify as data to be cloned, must exist on `tinydata`. You will be asked the name of the new app for which you want to create data files based on the ```redis``` structure. Names are automatically converted.


### Local or remote integration tests (WIP)

Since ```tp``` knows everything (well, enough) about the applications it installs, it knows how to check if they are working correctly.

This can be effortlessly and automatically enabled by using ```tp::test``` for the applications you want to test (or by setting to true the ```test_enable``` argument when using tp::install).

In this `control-repo` `tp` testing is enabled by default on all `tp` installed applications with the following entry on ```hieradata/common.yaml``` which is used in ```manifests/site.pp```:

    ---
      tp::test_enable: true

The following `Fabric task` (will) allow to test on a remote server if applications installed by `tp` are working correctly. Can be used in `CI pipelines`, for quick tests or monitoring.

    fab tp.remote_test -H <hostname>

You can test if `tp` installed applications are correctly running just by executing the scripts under ```/etc/tp/test``` on your servers.
