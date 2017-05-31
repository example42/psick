## Vagrant integration

This control-repo contains different customizable Vagrant environments that can be used for different purposes at different stages of our Puppet workflow: local testing during development, continuous integration testings, semi-permanent test environments...

This control-repo is by default shipped as self contained:

  - It provides all the Puppet code and data needed to provision different roles.

  - It manages nodes classification with a nodeless approach based on roles (or however is customized ```manifests/site.pp```.

  - It doesn't use exported resources (at least in common roles) or any other data provided by PuppetDB

  - It doesn't rely on an External Node Classifier (ENC) for nodes classification

Being self contained the catalog for each node can be compiled locally via Puppet apply, and is the same method used, by default, in most of the provided Vagrant environments.

We can work with them directly issuing ```vagrant``` commands in ```vagrant/environments/<env_name>``` or via Fabric from the main repo dir.


### Vagrant commands

We can use normal vagrant commands by moving in the relevant environment (where a ```Vagrantfile``` is placed) under the ```vagrant/environments/``` directory.

Here we can see a multi VM ```Vagrantfile``` and its ```config.yaml``` file.

This configuration file provides a quite flexible way to customize the nodes we want to see with our ```vagrant status``` (*Only this feature would deserve a dedicated Project*). Read below for more details on how to work with it.

Basic vagrant commands (here used a sample VM called centos7.devel):

    cd vagrant/environments/ostest
    vagrant status
    vagrant up centos7.devel

If we change our Puppet manifests or data in the control-repo we can immediately test their effect:

To provision Puppet using our current local copy of the control-repo:

    vagrant provision centos7.devel

To do the same from the local vm:

    vagrant ssh centos7.devel
    vm $ sudo su -
    vm # /etc/puppetlabs/code/environments/production/bin/papply.sh

If we want to use a Puppet Master for Puppet provisioning on the VM:

    vm # puppet agent -t

Note that by default a puppet apply is used and so it can work on the local control-repo files (mounted on the Vagrant VM). If we use a Puppet Master which is not in our Vagrant environment we will test the code present on the Master itself.


### Vagrant Fabric tasks

Vagrant commands can be invoked by Fabric too.

Generally it's handier to use direct vagrant commands from the relevant Vagrant environment directories, but we may prefer in some cases where automation is involved to use Fabric.

Run vagrant status on all the available Vagrant environments

    fab vagrant.env_status

Run vagrant status on a specific Vagrant environment

    fab vagrant.env_status:ostest

Run vagrant provision on all the running vm of a Vagrant environment:

    fab vagrant.provision:env=pe

Run vagrant up on the given vm (the following 2 commands are equivalent):

    fab vagrant.up:vm=centos7.devel
    fab vagrant.up:centos7.devel

Run, respectively, vagrant provision, reload, halt, suspend, resume, destroy on a given vm:

    fab vagrant.provision:centos7.devel
    fab vagrant.reload:centos7.devel
    fab vagrant.halt:centos7.devel
    fab vagrant.suspend:centos7.devel
    fab vagrant.resume:centos7.devel
    fab vagrant.destroy:centos7.devel


