# example42 control-repo and Vagrant

This contro-repo contains different customisable Vagrant environments that can be used for different purposes ad different stages of your Puppet workflow: local testing during development, continuous integration testings, semi-permanent test environments...

This control-repo is by default shipped as self contained:

  - It provides all the Puppet code and data needed to provision different roles.
  
  - It manages nodes classification with a nodeless approach based on roles (or however is customised ```manifests/site.pp```.
 
  - It doesn't use exported resources (at least in common roles) or any other data provided by PuppetDB
  
  - It doesn't rely on an ENC for nodes classification

Being self contained the catalog for each node can be compiled locally via Puppet apply, and is the same method used, by default, in the provided Vagrant environments.

You can work with them directly issuing ```vagrant``` commands in ```vagrant/environments/<env_name>``` or via Fabric from the main repo dir.


### Vagrant commands

You can use normal vagrant commands by moving in the relevant environment (where a ```Vagrantfile``` is placed) under the ```vagrant/environments/``` directory.

Here you can see a multi VM ```Vagrantfile``` and its ```config.yaml``` file.

This configuration file provides a quite flexible way to customise the nodes you want to see with your ```vagrant status``` (*Only this feature would deserve a dedicated Project*). Read below for more details on how to customise it.

Basic vagrant commands (here used a sample VM called centos7.ostest.psick.io):

    cd vagrant/environments/ostest
    vagrant status
    vagrant up centos7.ostest.psick.io

If you change your Puppet manifests or data in the control-repo you can immediately test their effect:

To provision Puppet using your current local copy of the control-repo:

    vagrant provision centos7.ostest.psick.io

To do the same from the local vm:

    vagrant ssh centos7.ostest.psick.io
    vm $ sudo su -
    vm # /etc/puppetlabs/code/environments/production/bin/papply.sh

If you want to use a Puppet Master for Puppet provisioning on the VM:

    vm # puppet agent -t 

Note that by default a puppet apply is used and so it can work on the local control-repo files (mounted on the Vagrant VM). If you use a Puppet Master which is not in your Vagrant environment you will test the code present on the Master itself.


### Vagrant Frabric tasks

Vagrant commands can be invoked by Fabric too.

Generally it's handier to use direct vagrant commands from the relevant Vagrant environment directories, but you may prefer in some cases where automation is involved to use Fabric.

Run vagrant status on all the available Vagrant environments

    fab vagrant.env_status

Run vagrant status on a specific Vagrant environment

    fab vagrant.env_status:ostest

Run vagrant provision on all the running vm of a Vagrant environment:

    fab vagrant.provision:env=pe

Run vagrant up on the given vm (the following 2 commands are equivalent):

    fab vagrant.up:vm=centos7.ostest.psick.io
    fab vagrant.up:centos7.ostest.psick.io

Run, respectively, vagrant provision, reload, halt, suspend, resume, destroy on a given vm:

    fab vagrant.provision:centos7.ostest.psick.io
    fab vagrant.reload:centos7.ostest.psick.io
    fab vagrant.halt:centos7.ostest.psick.io
    fab vagrant.suspend:centos7.ostest.psick.io
    fab vagrant.resume:centos7.ostest.psick.io
    fab vagrant.destroy:centos7.ostest.psick.io


## Customisations

In your own control-repo evolution you may want to:

  - Remove the vagrant/environments/ directories you don't use or need.

  - Add one or more custom environments for different use cases, such as Applications developers stations, Puppet developers stations, semi-permanent test environments, continuous integration environments...

  - Customise the ```config.yaml``` file to define size, OS, role, number of each vagrant vm.

  - Customise eventually the same ```Vagrantfile``` for your own needs. 

### Editing config.yaml

The ```config.yaml``` file is used by the local Vagrantfile to customise easily the VMs we want to use.

You can set the general settings valid for all the VM:

    vm:
      memory: 512            # Memory in MB of the VM
      cpu: 1                 # vCPUs of the VM
      role: ostest           # The default Puppet role (you may not want to set it here)
      box: centos7           # The default Vagrant box to use (from the list under ```boxes```)
      puppet_apply: true     # If to provision with puppet apply executed on the local files
      puppet_agent: false    # If to provision with puppet agent (you have to take care of setting up your Puppet Master)

Manage general network settings:

    network:
      range: 10.42.45.0/24   # The network to use for VMs internal lan
      ip_start_offset: 101   # The starting IP in the above range (if an ip_address is not explicitly set for a VM)
      domain: ostest.psick.io  # The DNS domain of your VMs

Manage Puppet related settings:

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

Finally it's possible to define the Vagrant boxes to use for the different VMs:

    boxes:
      centos7:                                # Box name as referenced under ```vm``` or ```nodes```
        box: puppetlabs/centos-7.2-64-puppet  # Name of Vagrant box on Atlas
        breed: puppetlabs-centos7             # Breed of the OS. Read later for more info.
      centos6:                                # Another box to select from...
        box: puppetlabs/centos-6.6-64-puppet
        breed: puppetlabs
      ubuntu1604:                             # Another box
        box: puppetlabs/ubuntu-16.04-64-puppet
        breed: puppetlabs-apt
      ubuntu1404:                             # Another box
        box: puppetlabs/ubuntu-14.04-64-puppet
        breed: puppetlabs-apt
    
The ```breed``` string defined for each box is passed during Vagrant provisioning for the local installation of Puppet (where needed) to the script ```vagrant/bin/vagrant-setup.sh```.

You may want to edit this script to add support for new breeds (if VMs of not listed Vagrant boxes (note that the above list is a subset of the current ones).


### Customising the Vagrantfile and the relevant scripts

Even if just by editing the ```config.yaml``` file you should be able to manage most of the common use cases, you may need to customise the ```Vagrantfile``` of an environment. 

Here you have full freedom, just notice that when changing it you may break some of the ```config.yaml``` functionality, and that the scripts used during provisioning or in Vagrant related activities are under ```vagrant/bin/``` and you might need to edit them too.


## Prerequisites: 

For a correct setup of the Vagrant environment you need:

  - Vagrant locally installed

  - Virtual Box locally installed

  - Possibly some extra Vagrant plugins:

        vagrant plugin install vagrant-cachier
        vagrant plugin install vagrant-vbguest
        vagrant plugin install vagrant-hostmanager
        vagrant plugin install vagrant-triggers
        vagrant plugin install pe_build # On Vagrant environments where Puppet Enterprise is used


The Vagrant steps are basically what's done by the setup script (you may have to run it as privileged used):

    bin/vagrant_setup.sh

Also this one can be invoked by Fabric:

    fab vagrant.setup


