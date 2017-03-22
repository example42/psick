<img align="right" src="html/images/PSICK-logo-200x200.png" />

## PSICK
## Puppet Systems Infrastructure Construction Kit

A **Puppet control-repo generator** on steroids, featuring:

  - A modern, opinionated, general purpose, full featured, reusable control-repo
  - Multiple ways to test local Puppet code (on Docker, Vagrant or directly remote hosts)
  - Gitlab CI pipeline to control Puppet code deployment
  - Usable in any Puppet setup, based on Puppet OSS, PE, Foreman...
  - Ready to use profiles for system baselines and common applications
  - Toolset to create and maintain a new control-repo based on PSICK

PSICK is a Puppet control-repo itself, you can use ths repository directly in a Puppet environment,
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

The psick command allows you to create a new control-repo and populate it either with a bare
minimal skeleton, or with the full PSICK contents.
In the future it will provide the possibility to pick single components (integrations, profiles...),
see how they diff compared to your own control-repo and eventually update them on your local contro-repo.

Once you have created your control-repo you can start to work with it.
If you have chosen to copy the full PSICK contents in your control repo, you can run the following commands
from your own control-repo directory, otherwise run them from the PSICK directory.
This applies to all the scripts and paths referenced in the docs.


### Setup of a Puppet environment

This control-repo requires Puppet 4, it's not already installed install it with:

    bin/puppet_install.sh

Before starting to use it, you have to populate the ```modules/``` directory.

To install the prequequisite gems (hiera-eyaml, deep_merge, r10k) and populate the external modules directory via r10k, you can run: 

    bin/puppet_setup.sh

If you have already r10k and the prerequisite gems, just run:

    r10k puppetfile install -v

If you also want to install the recommended (Fabric, Vagrant, Docker) tools that can be used with the repo, run:

    bin/setup.sh

The script, installs and runs r10k and then uses Puppet to install the other software. You will be asked to confirm or skip each step.

NOTE: Scripts are mostly tested on Mac and Linux environments.

For unattended setups (typically in CI pipelines) you can skip confirmation requests with:

    bin/setup.sh auto


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

