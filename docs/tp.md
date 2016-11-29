# example42 control-repo and Tiny Puppet

This Puppet contro-repo has various interesting integrations with Tiny Puppet, even if the integration is totally optional, we strongly recommend to give it a try by using and practising about it.

Usage of Tiny Puppet and tinydata (they are both present in the ```Puppetfile``` is at different levels:

  - Several sample profiles use tp defines to manage resources

  - Some (currently experimental) external modules use tp in module

  - It's possible to easily install any (known) app locally, via a tp shell wrapper

  - It's possible to create easily data for new apps to manage

  - Integration tests are free on multiple apps and os  out of the box with tp::test


### Install anything anywhere with a tiny command

Image a simple command, which expects as input the the name of an application or software and installs it, taking care of the underlying operating system, the eventual repositories that provide packages, how their names are different on different operating systems, if that app needs other apps or packages installed as prerequisites.

Something like ```install <software>``` that works everywhere.

Here it exists. To install locally (you might need root privileges ) any application on any operating systems, managing all the necessary dependencies:

    bin/tp_install.sh <app_name>

Or if you prefer to run it via Fabric:
 
    fab tp.install:<app_name>

Prequesities for the magic to happen:

  - Puppet 4 is installed locally

  - This control-repo is provisioned locally (that is it has run r10k to fetch tp and tinydata modules from upstream source)

  - There's in tinydata all the needed data to install the application on your OS.

If this does not work on your system, open a Bug Fix on tinydata, or send your PR with correction. The underlying tools to manage everything are there, it's just a matter or prevising the right data for all the different use cases.

Some possible uses
    # Setup epel (on RHEL systems)
    bin/tp_install.sh epel

    # Install sysdig (automatically manages dependencies with tp >= version 1.2 and tinydata >= v0.0.14 )
    bin/tp_install.sh sysdig
 
    # Install puppetserver from Puppet official repos
    bin/tp_install.sh puppetserver

    # Install docker from Docker official repos
    bin/tp_install.sh docker-engine

    # Install OpenJDK
    bin/tp_install.sh openjdk-jdk

    # Install apache for the lazy or mindless ones
    bin/tp_install.sh apache

If some of these or other commands don't work for the selected app on your local operating system, then it's probably a matter of missing or wrong tinydata, which can be easily solved.

Current support for most of the applications in tinydata is for Linux. MacOS and Windows support is technically present, but data is missing for most of the applications.


### Create tiny data for a new application

To clone the structure of the tinydata directory of an existing application and create data for a **new** app:

   fab tp.clone_data:redis

redis, or whatever you specify as data to be cloned, must exist on tinydata. You will be asked the name of the new app for with create data files based on the redis structure.

### Local or remote integration tests (WIP)

Since tp knows everything (well, enough) about the applications it installs, it knows how to check if they are working correctly.

This can be effortlessly and automatically enabled by using ```tp::test``` on the applications want to test (or by setting to true the ```test_enable``` argument when using tp::install).

In this control repo it's tp testing is enabled by default on all tp installed applications with the following entry on ```hieradata/common.yaml```:

    ---
      tp::test_enable: true

The following Fabric task (will) allow to test on a remote server if applications installed by tp are working correctly. Can be used in CI pipelines, for quick tests or monitoring.

    fab tp.remote_test -H <hostname>


