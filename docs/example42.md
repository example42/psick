- [example42. PSICK, control-repo and modules](#example42-psick-control-repo-and-modules)
  - [Example42 modules evolution](#example42-modules-evolution)
  - [Installing single example42 Puppet modules](#installing-single-example42-puppet-modules)
  - [Old versions installation](#old-versions-installation)
  - [Single Modules](#single-modules)

## example42. PSICK, control-repo and modules

`PSICK` is the result of years of work on `Puppet code` and modules.

`Example42` started to release `Puppet modules` in 2009 having, since the very beginning,
the vision to provide a reusable set of `Puppet code` able to manage in an integrated
way a whole infrastructure automating backup and monitoring functionalities.

Even if `PSICK` itself is born in 2017 it's derived from `Example42's` original [control-repo](https://github.com/example42/control-repo-original),
which was itself the evolution of `example42 Puppet modules` collection.


### Example42 modules evolution

`Example42` original idea of making reusable te design of a whole infrastructure with `Puppet`
has evolved through various iterations:

* "OLD" `Example42` `Puppet modules` (Version 1.x) are no more supported or recommended.
  They are supposed to work also on `Puppet` versions 0.x.
  You can give them a look using the 1.0 branch of [this repo](https://github.com/example42/control-repo-original).

* "NextGen" `Example42` `Puppet modules` (Version 2.x) were made before the release of `Puppet 3`.
  They are compatible with `Puppet` version 2.6 , 3 and, for most, 4 and require `example42's` `puppi module`.
  Most of the modules you still see on the `Forge` belong to this generation and most of them are
  now no more actively supported (we receive PR and fixes but we don't actively work on them).
  They were linked as `git submodules` on `branch 2.0` of the [original repo](https://github.com/example42/control-repo-original).

* `StdMod modules` (Version 3.x) were supposed to be the next evolution of `Example42 modules`.
  They adhere to [StdMod](https://github.com/stdmod/puppet-modules) naming standards and are compatible with `Puppet > 2.7 or 3.x`
  This is an half baked generation, which was abandoned for other projects.

* Version 4.x modules. Most of the old `pre-Puppet 4` modules have been deprecated and not maintained anymore.
  They are `Puppet 4` only compliant.
  The structure of the repo has changed radically, all the `git submodules` have been removed and a
  `control-repo` style has been introduced.
  With the release of 4.x this repo has been renamed: from **puppet-modules** to **control-repo**.

* With the introduction of `PSICK` we started release numbering from scratch, even if the amount of code
  inherited from the `control-repo` is quite relevant.
  We renamed the original `GitHub` repo from **control-repo** to **PSICK**
  and we zeroed the `git history`. You still can see it on the [archive repo](https://github.com/example42/control-repo-archive)
  for historical purposes (that repo in freezed and won't accept PR).

Why did we rename the `control-repo` to `PSICK` *and* zeroed the whole ancient history of that repo?

  - We wanted to have a clean `git history` and a tinier `git` repo, without 8 years of code stratifications

  - We wanted to start from scratch release `versioning`, `tags` and `branches`.

  - We think that the original concept of having a single place where to manage the whole `Puppet infrastructure`
    has been there since the very first iteration, even if in totally different shapes.

  - *Honestly*, most of all, we wanted to preserve `GitHub's` stars on our historic `Puppet modules` repository.


### Installing single example42 Puppet modules

Use the `Forge` to install single `example42 modules` (be aware of the deprecated or old (2.x) ones):

    puppet module search example42

or cherry pick them from [GitHub](https://github.com/example42).

**NOTE:** most of [example42 modules](https://github.com/example42) are obsolete and no more actively maintained.

Most of their functionality is reproduced by `Tiny Puppet` or by the `profiles` in this `control-repo`.

### Old versions installation

You can retrieve the old lists of `Example42 modules` from other versions with:

    git clone --recursive -b 1.0 git://github.com/example42/control-repo-archive.git
    git clone --recursive -b 2.0 git://github.com/example42/control-repo-archive.git
    git clone --recursive -b 3.0 git://github.com/example42/control-repo-archive.git

**NOTE:**  earlier versions are based on ```git modules``` and have not a `control-repo` structure.


### Single Modules

All the modules have a ```metadata.json``` file where dependencies are described.

Most of the modules require `PuppetLabs' stdlib`.
Some modules (the ones, of generation 2.x, which use the ```params_lookup``` function) require [Puppi](https://github.com/example42/puppi).
