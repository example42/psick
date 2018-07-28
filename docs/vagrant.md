- [Vagrant integration](#vagrant-integration)
  - [Vagrant commands](#vagrant-commands)
  - [Vagrant Fabric tasks](#vagrant-fabric-tasks)
  - [Customisations](#customisations)
  - [Editing config.yaml](#editing-configyaml)
    - [Environments](#environments)
    - [Agent or masterless?](#agent-or-masterless)
    - [Override options for each node](#override-options-for-each-node)
    - [Customising the Vagrantfile and the relevant scripts](#customising-the-vagrantfile-and-the-relevant-scripts)

## Vagrant integration

This `control-repo` contains different customisable `Vagrant` environments that can be used for different purposes at different stages of our `Puppet workflow`: `local` testing during development, `continuous integration` testing, `semi-permanent` test environments...

This `control-repo` is by default shipped as **self contained**:

  - It provides all the `Puppet code` and data needed to provision different roles.

  - It manages nodes classification with a nodeless, `Hiera driven`, approach based on the companion [psick module](https://github.com/example42/puppet-psick).

  - It doesn't use [exported resources](https://puppet.com/docs/puppet/latest/lang_exported.html) (at least in common roles) or any other data provided by `PuppetDB`

  - It doesn't rely on an `External Node Classifier` (ENC) for nodes classification

Being self contained the catalog for each node can be compiled locally via ```Puppet apply```, and is the same method used, by default, in most of the provided `Vagrant` environments.

We can work with them directly issuing `vagrant` commands in ```vagrant/environments/<env_name>``` or via `Fabric` from the main repo dir.


### Vagrant commands

We can use normal ```vagrant commands``` by moving in the relevant environment (where a `Vagrantfile` is placed) under the ```vagrant/environments/``` directory.

Here we can see a multi VM `Vagrantfile` and its ```config.yaml``` file.

This configuration file provides a quite flexible way to customize the nodes we want to see with our ```vagrant status``` (*Only this feature would deserve a dedicated Project*). Read below for more details on how to work with it.

Basic ```vagrant``` commands (here used a sample VM called ```centos7.ostest.psick.io```):

    cd vagrant/environments/ostest
    vagrant status
    vagrant up centos7.ostest.psick.io

If we change our `Puppet` manifests or data in the `control-repo` we can immediately test their effect:

To provision `Puppet` using our current local copy of the `control-repo:`

    vagrant provision centos7.ostest.psick.io

To do the same from the local vm:

    vagrant ssh centos7.ostest.psick.io
    vm $ sudo su -
    vm # /etc/puppetlabs/code/environments/production/bin/papply.sh

If we want to use a `Puppet Server` for `Puppet` provisioning on the VM:

    vm # puppet agent -t

Note that by default a ```puppet apply``` is used and so it can work on the local `control-repo` files (mounted on the `Vagrant VM`). If we use a `Puppet Server` which is not in our `Vagrant` environment we will test the code present on the `Puppet Server` itself.


### Vagrant Fabric tasks

`Vagrant` commands can be invoked by `Fabric` too.

Generally it's handier to use direct ```vagrant commands``` from the relevant `Vagrant` environment directories, but we may prefer in some cases where automation is involved to use `Fabric`.

Run ```vagrant status``` on all the available `Vagrant` environments

    fab vagrant.env_status

Run ```vagrant status``` on a specific `Vagrant` environment

    fab vagrant.env_status:ostest

Run ```vagrant provision``` on all the running vm of a `Vagrant` environment:

    fab vagrant.provision:env=lab

Run ```vagrant up``` on the given vm (the following 2 commands are equivalent):

    fab vagrant.up:vm=centos7.ostest.psick.io
    fab vagrant.up:centos7.ostest.psick.io

Run, respectively, ```vagrant provision```, ```reload```, ```halt```, ```suspend```, ```resume```, ```destroy``` on a given vm:

    fab vagrant.provision:centos7.ostest.psick.io
    fab vagrant.reload:centos7.ostest.psick.io
    fab vagrant.halt:centos7.ostest.psick.io
    fab vagrant.suspend:centos7.ostest.psick.io
    fab vagrant.resume:centos7.ostest.psick.io
    fab vagrant.destroy:centos7.ostest.psick.io

### Customisations

We can customise the `Vagrant` environments in various ways:

  - Remove the ```vagrant/environments/``` directories we don't use or need.

  - Add one or more custom environments for different use cases, such as Applications developers stations, Puppet developers stations, semi-permanent test environments, continuous integration environments...

  - Customise the ```config.yaml``` file to define size, OS, role, number of each vagrant vm.

  - Customise eventually the same `Vagrantfile` for our own needs.

### Editing config.yaml

The ```config.yaml``` file is used by the local `Vagrantfile` to customise easily the VMs we want to use.

Here we can set the general settings valid for all the VM:

    vm:
      memory: 512            # Memory in MB of the VM
      cpu: 1                 # vCPUs of the VM
      role: ostest           # The default Puppet role (you may not want to set it here)
      box: centos7           # The default Vagrant box to use (from the list under boxes)
      puppet_apply: true     # If to provision with puppet apply executed on the local files
      puppet_agent: false    # If to provision with puppet agent (you have to take care of setting up your Puppet Master)

Manage general network settings:

    network:
      range: 10.42.45.0/24   # The network to use for VMs internal lan
      ip_start_offset: 101   # The starting IP in the above range (if an ip_address is not explicitly set for a VM)
      domain: ostest.psick.io  # The DNS domain of your VMs

Manage `Puppet` related settings:

    puppet:
      version: latest        # Which version of Puppet to use (WIP)
      env: test              # Adds a fact called env to the VM with the given value
      zone: local            # Adds a fact called zone to the VM with the given value

Define the nodes list (as shown in ```vagrant status```):

    nodes:
      - role: log                    # Puppet role: log
        count: 1                     # How many instances of log servers to list
      - role: mon                    # Another node, another role
        count: 1
      - role: docker_tp_build        # Role: docker_tp_build
        hostname_base: docker-build  # Here the node name is overridden
        count: 1                  
        box: ubuntu1404              # Also the Vagrant box to use is different from the default one under vm
      - role: puppet                 # A puppet role for the Puppet Master
        count: 1
        memory: 4096                 # More memory than default for this VM
        cpu: 2                       # More vCPUS
        box: ubuntu1604              # Specific box...
        ip_address: 10.42.42.10      # Fixed IP address
        puppet_apply: true           # Force provisioning via puppet apply
        aliases:                     # Added aliases for Vagrant hostmanager plugin (if used)
          - puppet

Finally it's possible to define the ```Vagrant boxes``` to use for the different VMs, the list of available boxes is defined under ```vagrant/boxes.yaml```:

    boxes:
      centos7:                                # Box name as referenced under vm or nodes
        box: puppetlabs/centos-7.2-64-puppet  # Name of Vagrant box on Atlas
      centos6:                                # Another box to select from...
        box: puppetlabs/centos-6.6-64-puppet
      ubuntu1604:                             # Another box
        box: puppetlabs/ubuntu-16.04-64-puppet
      ubuntu1404:                             # Another box
        box: puppetlabs/ubuntu-14.04-64-puppet

#### Environments

In ```config.yaml``` there are some options involving which code will be run on host.

* `puppet > environment`: The environment to apply to the virtual machine

* `puppet > link_controlrepo`: Add a link for a `Puppet` environment to the development `control-repo`.  
  Setting this to true will create an environment "`host`" with our current uncommitted code.

* `puppet > controlrepo`: URL of the `control-repo` to deploy via `r10k` on `Puppet Server`.  
  Can be both a local or our local `control repo:`
    * `https://git.organization.tld/puppet.git`
    * `/vagrant_puppet` to use the local dir.

#### Agent or masterless?

We can execute the code in masterless mode or connecting to a `Puppet Server` inside `vagrant` environment.

* `vm > puppet_agent`: If set to true this will run ```puppet agent```, connecting to master configured in `puppet::master_fqdn`

* `vm > puppet_apply`: If set to false this will apply catalog, in masterless mode. This is mandatory to bootstrap the puppet master.

We can set both to true to run puppet twice, fist in masterless mode, then run the agent.

#### Override options for each node

The `node` key is an array of hosts to run. Here, we can override each option in `vm` and `pupet`.  
For example:

```yaml
  vm:
    memory: 1024

  puppet:
    environment: production

  node:
  - role: puppet
    memory: 6192
    puppet_apply: true
  - role: application_server
    environment: host
```

#### Customising the Vagrantfile and the relevant scripts

Most of the existing `Vagrant` environments share the same ```Vagrantfile```, but we may need to create a custom one, even if just by editing the ```config.yaml``` file we should be able to manage most of the common use cases.

Here we have full freedom, just notice that when changing the ```Vagrantfile``` we may break some of the ```config.yaml``` functionality, and that the scripts used during provisioning or in `Vagrant` related activities are under ```vagrant/bin/``` and we might need to edit them too.
