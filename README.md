<img align="right" src="html/images/PSICK-logo-200x200.png" />

## PSICK
## Puppet Systems Infrastructure Construction Kit

A **Puppet control-repo generator** on steroids, featuring:

  - A modern, opinionated, general purpose, full featured, reusable control-repo
  - Multiple ways to test local Puppet code (on Docker, Vagrant or directly remote hosts)
  - Gitlab CI pipeline to control Puppet code deployment
  - Usable in any Puppet setup, based on Puppet OSS, PE, Foreman...
  - Ready to use profiles for system baselines and common applications
  - Toolset to create and maintain a new control-repo based on PSICK (WIP)

PSICK is a Puppet control-repo itself, you can use this repository directly in a Puppet environment,
and basically have a full PSICK setup, or run the **psick** command to generate a new Puppet
control-repo based on the components you need.

Components can be:

  - Profiles (and relevant tools and hiera data) for different applications
  - Integrations with Vagrant, Docket, GitLab, Fabric...
  - Scripts, tools or addtional control-repo files

### Setup of a new control-repo

Download this repository:

    git clone https://github.com/example42/psick
    cd psick
    ./psick create

The psick command currently it just allows you to create a new control-repo and populate it either with a bare
minimal skeleton, or with the full PSICK contents.
In the future it will provide the possibility to pick single components (integrations, profiles...),
see how they diff compared to your own control-repo and eventually update them on your local contro-repo.

Once you have created your control-repo you can start to work with it.
If you have chosen to copy the full PSICK contents in your control repo, you can run the following commands
from your own control-repo directory, otherwise run them from the PSICK directory.
This applies to all the scripts and paths referenced in the docs, just be aware that some of the scripts in bin/
and other integrations might not work correctly in a not full PSICK setup.


### Setup of a Puppet environment

This control-repo requires Puppet 4, if it's not already installed, you can install it with this cross OS Puppet 4 install script (it uses the official Puppet repos):

    sudo bin/puppet_install.sh # Only if you don't have Puppet 4 installed

Before starting to use it, you have to populate the ```modules/``` directory of the control-repo.

You need to do this both on your **development** workstation, and on your **Puppet server** (after having placed your control-repo into the ```/etc/puppetlabs/code/environments/``` directory).

To install the prequequisite gems (hiera-eyaml, deep_merge, r10k) and populate the external modules directory via r10k, you can run: 

    bin/puppet_setup.sh        # Only if you don't have the prerequisites gems

If you have already r10k and the prerequisite gems, just run:

    r10k puppetfile install -v

If you also want to install the recommended (Fabric, Vagrant, Docker) tools that can be used with the repo, run:

    bin/setup.sh               # Only if you want to install Fabric, Vagrant and Docker

The script, installs and runs r10k and then uses Puppet to install the other software.

Notes:

  - You will be always asked to confirm or skip each step.

  - The script will use ```sudo``` for the operations that need root privileges.

  - Scripts are mostly tested on Mac and Linux environments. On Mac some packages installations don't work.

  - You can safely interrupt the scripts with CTRL+C at any time

  - For unattended setups (typically in CI pipelines) you can skip confirmation requests passing the argument auto:

        bin/puppet_setup.sh auto
        bin/setup.sh auto


### Directory structure

PSICK has the common set of files and directories of a Puppet control-repo:

  - ```environment.conf``` - The Puppet environment configuration file

  - ```manifests/``` - Directory with the main manifests. Here we have just ```site.pp```

  - ```Puppetfile``` - File that defines the external modules to add via r10k

  - ```modules/``` - Directory where modules defined in Puppetfile are placed (it's .gitignored)

  - ```hiera.yaml``` - Hiera 5 environment configuration file. An equivalent Hiera 3 file is ```hiera3.yaml``` (was linked to ```/etc/puppetlabs/puppet/hiera.yaml```)   

  - ```hieradata/``` - Directory where Hiera data is stored, in Yaml files.

Some extra directories are added in PSICK for integrations and tools:

  - ```bin/``` - Directory containing tools and scripts for various Puppet related operations

  - ```docs/``` - Directory with extra docs

  - ```site/``` - An additional modules directory, with local profiles and tools.

  - ```docker/``` - Files used for building Docker images for multiple OS

  - ```vagrant/``` - Various Vagrant environments where is possible to test local Puppet code

  - ```fabfile/``` - Fabric integration and scripts

  - ```skeleton/``` - A skeleton of a Puppet 4 module, to use with ```puppet module generate```

  - ```.gitlab-ci.yaml``` - (Sample) GitLab Continuous Integration pipeline for code testing and deployment


### Documentation

PSICK is full of more or less hidden stuff, which ease a lot Puppet code development, testing and deployment.

For more information on specific topics:

  - [Using and understanding the control-repo](docs/use.md) - An overview of the control-repo and how to understand, use and customise it
  
  - [Prerequisites](docs/prerequisites.md) - A more detailed view of the prerequisites needed to fully use the control-repo

  - [Development Workflow](docs/workflow.md) - An introduction of possible commands and workflows for Puppet code management

  - [Vagrant Integration](docs/vagrant.md) - How to use Vagrant to test the control-repo while deployment

  - [Docker Integration](docs/docker.md) - How to use Docker to test Puppet code and to build images based on the existing Puppet code

  - [AWS Integration](docs/aws.md) - How to use Puppet to query and configure AWS resources from the control-repo

  - [Noop Mode](docs/noop_mode.md) - An overview on how to enforce noop mode server side with this repo

  - [Trusted Facts](docs/trusted_facts.md) - How to set and use trusted facts in this control-repo

  - [Hiera eyaml](docs/hiera_eyaml.md) - An overview on how to use hiera-eyaml

  - [Git tasks](docs/git.md) - A review of Git tasks available with Fabric

  - [Puppet tasks](docs/puppet.md) - A review of Puppet tasks available with Fabric

  - [Tiny Puppet Integrations](docs/tp.md) - Learn about Tiny Puppet and the integrations in this control-repo

  - [example42 history](docs/example42.md) - A summary of the evolution of example42 modules and control-repo

