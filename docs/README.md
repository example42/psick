- [Puppet control-repo documentation](#puppet-control-repo-documentation)
  - [Documentation](#documentation)
    - [General Puppet documentation:](#general-puppet-documentation)
    - [About this control-repo:](#about-this-control-repo)
    - [Managing changes:](#managing-changes)

# Puppet control-repo documentation

This [Puppet](https://www.puppet.com/) `control-repo` contains all the `Puppet code` and `data` needed to manage an IT infrastructure in an automated, centralized, way.

It's based on [PSICK control-repo](https://github.com/example42/psick), Example42's Puppet Systems Infrastructure Construction Kit and the companion [PSICK module](https://github.com/example42/puppet-psick)

It's a [Git](https://git-scm.com) repository where changes have to be committed and updated code deployed on the `Puppet Servers` in order to actually deliver modifications to our systems via `Puppet`.

A proper understanding of `Puppet` key principles is necessary to operate here.

In this document are outlined the main principles behind `Puppet` and the logic of this `control repo:` it should be all we need to be able to work on it.

Some references and basic information on `Puppet` are provided later, here we start by describing what are the main components of a typical `control-repo` and then what are the specific additions done here.


## Documentation

### General Puppet documentation:

  - [Introduction to Puppet](#label-Introduction+to+Puppet) - A very basic introduction to `Puppet`

  - [Hiera essentials](#label-hiera) - Basic `Hiera` concepts

  - [Hiera eyaml](#label-hiera+eyaml) - An overview on how to use `hiera-eyaml`

  - [Trusted Facts](#label-Trusted+facts) - How to set and use `trusted facts`

  - [External Facts](#label-External+facts) - How to set and use `external facts`

  - [Puppet Enterprise Console](#label-Puppet+Enterprise+Console) - An overview on the `Puppet Enterprise console`


### About this control-repo:

  - [Control-repo logic](#label-Using+and+understanding+this+control-repo) - An overview of the design choices and the logic of this `control-repo`.

  - [Prerequisites](#label-Prerequisites) - A more detailed view of the prerequisites needed to fully use the `control-repo`

  - [Noop Mode](#label-Puppet+noop+mode) - An overview on how to enforce `noop mode server side` with this repo

  - [Vagrant Integration](#label-Vagrant+integration) - How to use `Vagrant` to test the `control-repo` during development

  - [Docker Integration](#label-Docker+integration) - How to use `Docker` to test `Puppet code` and to build images based on the existing `Puppet code`

  - [Fabric](#label-Fabric) - A review of `Puppet tasks` available with `Fabric`


### Managing changes:

  - [Git tasks](#label-Git) - An overview on how to use `Git`

  - [Change Process](#label-Puppet+change+process) - A `step-by-step` guide on how to manage changes in `Puppet code`
