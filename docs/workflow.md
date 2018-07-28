- [Puppet code management workflow with Fabric](#puppet-code-management-workflow-with-fabric)
    - [Setup of the control-repo](#setup-of-the-control-repo)
        - [Just playing around](#just-playing-around)
        - [Forking example42's control repo](#forking-example42s-control-repo)
        - [Starting from scratch](#starting-from-scratch)
    - [Development workflow based on Fabric tasks](#development-workflow-based-on-fabric-tasks)
    - [Testing your code](#testing-your-code)
        - [On live servers](#on-live-servers)
        - [With Docker](#with-docker)
        - [With Vagrant](#with-vagrant)
    - [Managing Puppet code deployment and runs](#managing-puppet-code-deployment-and-runs)

## Puppet code management workflow with Fabric

All the ```.py``` files in the main directory of this `control-repo` are `Fabric` configuration files.

We use them to provide the toolset to `setup`, `develop`, `test` and `deploy` a `Puppet environment`.

To use all the available features you should have locally installed:

  - [Puppet](https://puppet.com/docs/puppet/latest/puppet_index.html)

  - [Vagrant](https://www.vagrantup.com/)

  - [Docker](https://www.docker.com/)

  - [Fabric](http://www.fabfile.org/installing.html)

  - [Git](https://git-scm.com/)

### Setup of the control-repo

You can follow alternative approaches on how to play or work with this `control-repo`, eventually with the intention to customise it for your own use.

#### Just playing around

The quickest way to start to play around:

    git clone https://github.com/example42/psick
    cd psick
    bin/setup.sh

#### Forking example42's control repo

You can [fork](https://help.github.com/articles/fork-a-repo/) `PSICK` [control-repo](https://github.com/example42/psick) on `GitHub` and then work on your fork as `origin` and add example42 repo as `upstream`, in order to ease (always welcomed) `Pull Requests` for issues of features:

    git clone https://github.com/<yourname>/psick
    cd psick
    git remote add upstream https://github.com/example42/psick

#### Starting from scratch

If you want to start a `Git repo` from scratch, wiping out the history (and the ability to easily merge back) of `example42 control-repo`, you can:

    git clone https://github.com/example42/psick
    cd psick
    fab git.setup_new_repo

You will be asked the name of the directory where to create the new `Git repository`. It's placed on the same parent dir of the original `control-repo`.

To do this in an unattended way you can specify the directory name:

    fab git.setup_new_repo:my_repo

Once done, you can move into the new directory, with only a branch, called ```production``` and no commits.

Select the files to keep or remove, then commit them all

    git commit -a -m "Repo based on https://github.com/example42/psick"

Now you can set the `origin` push your repo to an empty existing repo you have created on `GitHub/Bitbucket/GitLab/...` :

    git remote add origin git@github.com:example42/psick.git
    git push -u origin --all


### Development workflow based on Fabric tasks

Show available Fabric tasks:

    fab -l

Run a `Fabric task` with one of these alternatives:

    fab <task>[:host=<hostname>][:option=value]
    fab [-H <hostname>] <task>[:option=value]>

Initial setup to ensure the needed `Puppet` related software is installed locally:

    fab puppet.setup

Install useful `Git hooks` for `Puppet` development. By default downloaded from [https://github.com/drwahl/puppet-git-hooks](https://github.com/drwahl/puppet-git-hooks):

    fab git.install_hooks

Note that existing git hooks are not overwritten by this task. Once installed you can eventually configure them:

    vi .git/hooks/commit_hooks/config.cfg

Now you can start to configure and develop your `Puppet code` and `data:`

  - Customise the ```hiera.yaml``` to match your needs.

  - Modify and add `Hiera` ```.yaml``` files in ```hieradata```

  - Write your site modules

  - Customize `Puppetfile` with the used external modules

To generate a new module with [PDK](https://puppet.com/docs/pdk/latest/pdk.html).

    fab puppet.module_generate

During development you can check the ```git status``` of the main `control-repo` and of each module in ```modules``` with:

    fab git.status

### Testing your code

There are different methods available for testing your code before pushing it to to production. You can use some or all of them, both manually during your development activities and automatically in `Continuous Integration pipelines`.


#### On live servers

If you don't use `external node classifiers` or don't rely on `PuppetDB` for resource management (via `exported resources` or direct queries during compilation) and if, basically, your `control-repo` is self consistent (has all the `Puppet code` and `data` to classify nodes), you can test your code directly on a live machine, even before committing it. You need ```ssh``` access to such node.:

    fab puppet.sync_and_apply:$role,[$puppet_options]

To test on node ```web01.example.com``` the ```role web``` in `noop mode`:

    fab -H web01.example.com puppet.sync_and_apply:web,'--noop'

To actually `apply` the ```role web``` to the given node **WARNING: Real changes done on servers here**:

    fab -H web01.example.com puppet.sync_and_apply:web

The above command is recommended only if you are sure of what you are doing and should be done only if your deployment and testing policies accepts it. In normal conditions you can test you code by using `branches` of your `control-repo` which, when deployed via `r10k` can be tested as `Puppet environments`.

In such situations, you can test you code with a normal ```puppet agent``` command, pointing to the local `Puppet Server:`

    fab -H <node> puppet.agent_noop:[environment]

So to run a `noop` `Puppet run` on the given node for a specific `Puppet environment` (names as a branch of your `control-repo`, default is production) you can issue commands like:

    fab -H web01.example.com puppet.agent_noop:test_feature

To make a real `Puppet run` on a given node:

    fab -H <node> puppet.agent:[environment]
    fab -H web01.example.com puppet.agent # Normal Puppet agent run using production environment
    fab -H web01.example.com puppet.agent:test_festure # Puppet agent run using an environment called test_feature


#### With Docker
To test a role (as defined in ```hieradata/role/$role.yaml```) with `Docker` on different OS base images:

    fab docker.provision:<role>,<image>
    fab docker.provision:log,ubuntu-14.04

Available images are: ```ubuntu-12.04```, ```ubuntu-14.04```, ```ubuntu-14.06```, ```centos-7```, ```debian-7```, ```debian-8```, ```alpine-3.3```.


#### With Vagrant

There are different `Vagrant` environment available. You can pick any of them, like the ```lab``` one to test your own different roles.

First review and edit the configuration file for the `Vagrant` environment

    vi vagrant/environments/lab/config.yaml

Then either run `vagrant commands` from the relevant repo:

    cd vagrant/environments/lab
    vagrant status
    vagrant up <vm>
    vagrant provision <vm>

For the same commands there are `Fabric tasks` which are more wrappers for automation or information gathering purposes:


Run ```vagrant status``` on all the available `Vagrant` environments (useful also to see the names of the VMs you can use in the following commands):

    fab vagrant.all_status

Run ```vagrant provision``` on all the running vm of a `Vagrant` environment:

    fab vagrant.provision:env=lab

Run `vagrant commands` on a given VM (ignore the warnings for not finding a given VM in all the available environments)

    fab vagrant.up:vm=dev-local-docker-build-01
    fab vagrant.status:vm=dev-local-docker-build-01
    fab vagrant.provision:vm=dev-local-docker-build-01
    fab vagrant.reload:vm=dev-local-docker-build-01
    fab vagrant.halt:vm=dev-local-docker-build-01
    fab vagrant.suspend:vm=dev-local-docker-build-01
    fab vagrant.resume:vm=dev-local-docker-build-01
    fab vagrant.destroy:vm=dev-local-docker-build-01


### Managing Puppet code deployment and runs

Run ```puppet agent``` in `noop mode` on all the known hosts:

    fab puppet.agent_noop

Run ```puppet agent``` in a specific node:

    fab puppet.agent:host=web01.example.test

Show the current version of deployed `Puppet code` on all known hosts:

    fab puppet.current_config
