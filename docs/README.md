- [Puppet control-repo documentation](#puppet-control-repo-documentation)
  - [Documentation](#documentation)
    - [General Puppet documentation:](#general-puppet-documentation)
    - [About this control-repo:](#about-this-control-repo)
    - [Managing changes:](#managing-changes)
    - [Control-repo in action](#control-repo-in-action)

# Puppet control-repo documentation

This [Puppet](https://www.puppet.com/) `control-repo` contains all the `Puppet code` and `data` needed to manage an IT infrastructure in an automated, centralized way.

It's based on [PSICK control-repo](https://github.com/example42/psick), Example42's `Puppet Systems Infrastructure Construction Kit` and the companion [PSICK module](https://github.com/example42/puppet-psick). Brief history of the `control-repo` evolution is [here](example42.md).

It's a [Git](https://git-scm.com) repository where changes have to be committed and updated code deployed on the `Puppet Servers` in order to actually deliver modifications to our systems via `Puppet`.

A proper understanding of `Puppet` key principles is necessary to operate here.

In this document are outlined the main principles behind `Puppet` and the logic of this `control repo:` it should be all we need to be able to work on it.

Some references and basic information on `Puppet` are provided later, here we start by describing what are the main components of a typical `control-repo` and then what are the specific additions done here.


## Documentation

### General Puppet documentation:

  - [Introduction to Puppet](puppet.md) - A very basic introduction to `Puppet`

  - [Hiera essentials](hiera.md) - Basic `Hiera` concepts

  - [Hiera eyaml](hiera_eyaml.md) - An overview on how to use `hiera-eyaml` backend

  - [Trusted Facts](trusted_facts.md) - How to set and use `trusted facts`

  - [External Facts](external_facts.md) - How to set and use `external facts`

  - [Puppet Enterprise Console](pe_console.md) - An overview on the `Puppet Enterprise console`


### About this control-repo:

  - [Control-repo logic](use.md) - An overview of the design choices and the logic of this `control-repo`

  - [Prerequisites](prerequisites.md) - A more detailed view of the prerequisites needed to fully use the `control-repo`

  - [Noop Mode](noop_mode.md) - An overview on how to enforce `server side` `noop mode` with this `control-repo`

  - [Fabric](fabric.md) - A review of `Puppet tasks` available with `Fabric`

  - Integrations:

    - [Vagrant Integration](vagrant.md) - How to use `Vagrant` to test the `control-repo` during development

    - [Docker Integration](docker.md) - How to use `Docker` to test `Puppet code` and to build images based on the existing `Puppet code`

    - [Puppet Enterprise and Gitlab integration](pe_gitlab.md) - How to setup and use `Puppet Enterprise` with `Gitlab` for full development cycle of `Puppet code` and `data`
    
    - [Tiny Puppet and tinydata integration](tp.md) - How to extend `Puppet` usage with `Tiny Puppet` and `tinydata`


### Managing changes:

  - [Git tasks](git.md) - An overview on how to use `Git`

  - [Change Impact](change_impact.md) - Some `Warnings` **before** messing up with `Puppet code` and `data`

  - [Change Process](change_process.md) - A `step-by-step` guide on how to manage changes in `Puppet code`

    - [Workflow example](change_process_integration.md) -  A Change process workflow with, `feature`, `integration`, and `production branch`


### Control-repo in action

  - [AWS](aws.md) - How to setup and manage `AWS` resources
  
  - [FOSS Puppet Server](FOSS_puppet_server.md) - How to spin up a `Puppet Open Source Server` in a fully automated way
