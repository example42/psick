    - [Setup of the control-repo](#setup-of-the-control-repo)
        - [Just playing around](#just-playing-around)
        - [Forking example42's control repo](#forking-example42s-control-repo)
        - [Starting from scratch](#starting-from-scratch)
    - [Testing your code](#testing-your-code)
        - [On live servers](#on-live-servers)
        - [With Docker](#with-docker)
        - [With Vagrant](#with-vagrant)
    - [Managing Puppet code deployment and runs](#managing-puppet-code-deployment-and-runs)


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

You will be asked the name of the directory where to create the new `Git repository`. It's placed on the same parent dir of the original `control-repo`.

Once done, you can move into the new directory, with only a branch, called ```production``` and no commits.

Select the files to keep or remove, then commit them all

    git commit -a -m "Repo based on https://github.com/example42/psick"

Now you can set the `origin` push your repo to an empty existing repo you have created on `GitHub/Bitbucket/GitLab/...` :

    git remote add origin git@github.com:example42/psick.git
    git push -u origin --all


#### With Vagrant

There are different `Vagrant` environment available. You can pick any of them, like the ```lab``` one to test your own different roles.

First review and edit the configuration file for the `Vagrant` environment

    vi vagrant/environments/lab/config.yaml

Then either run `vagrant commands` from the relevant repo:

    cd vagrant/environments/lab
    vagrant status
    vagrant up <vm>
    vagrant provision <vm>
