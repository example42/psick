- [Vagrant integration](#vagrant-integration)
  - [Vagrant commands](#vagrant-commands)
  - [Vagrant directory structure](#vagrant-directory-structure)
  - [Customisations](#customisations)
  - [Editing config.yaml](#editing-configyaml)

## Vagrant integration

This `control-repo` contains different customisable `Vagrant` environments that can be used for different purposes:

  - Virtual machines with different OS where to test our Puppet code before committing it
  - VMs to use in automated CI pipelines
  - VMS to use by application developers configured via Pupept and aligned to prod servers

This `control-repo` is by default shipped as **self contained**:

  - It provides all the `Puppet code` and data needed to provision different roles.
  - It manages nodes classification with a nodeless, `Hiera driven`, approach based on the companion [psick module](https://github.com/example42/puppet-psick).
  - It doesn't use [exported resources](https://puppet.com/docs/puppet/latest/lang_exported.html) (at least in common roles) or any other data provided by `PuppetDB`
  - It doesn't rely on an `External Node Classifier` (ENC) for nodes classification

Being self contained the catalog for each node can be compiled locally via ```Puppet apply```, and this is the same method used, by default, in most of the provided `Vagrant` environments.

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

### vagrant directory structure

All the vagrant integration is under the ```vagrant``` directory (*). Here we find the following files:

  - `Vagrantfile` a common Vagrantfile, shared by all the different vagrant environments, which parses the environments' `config.yaml` and creates a multivm Vagrant setup
  - `bin/` a directory with various scripts used by provisioners in the Vagrantfile (referred via the relative path `../../bin/` as all the actual vagrant actions are run inside environments dirs)
  - `boxes.yaml` a definition of each available boxes and the relevant source. Any of these can be used by nodes defined in the environments' `config.yaml`
  - `environments` a directory containining different directories, one of each Vagrant environment which can be used.

(*) The following scripts are OUTSIDE the vagrant directory but might be used in the Vagrantfile (if relevant config options are used), they are referred with the relative path: `../../../bin`:

  - `bin/puppet_install.sh` installs Puppet agent on different OS
  - `bin/puppet_deploy_controlrepo.sh` runs `r10k deploy environment -v` inside the VM to deploy under /etc/puppetlabs/code/environments/ the control-repo and relevant modules
  - `bin/puppet_set_trusted_facts.sh` configures trusted facts on the VM's `/etc/puppetlabs/puppet/csr_attributes.yaml` file
  - `bin/puppet_set_external_facts.sh` configures external facts under the VM's `/etc/puppetlabs/facter/facts.d/` dir

The most interesting Vagrant environments are:

  - `environments/lab`: This is the lab environment where example42 tests psick Puppet code. Relevant Hiera data is [here](https://github.com/example42/psick-hieradata/blob/production/data/zone/lab.yaml) and in node/role specific files. It's based on a Puppet Enterprise + GitLab setup, where both server and clients live withing the environment. You are not supposed to use it as is, but it's useful as reference.
  - `environments/bare`: This is useful to test anything on vanilla boxes. No Puppet agent is automatically installed on these VMs. 
  - `environments/ostest`: This is useful to test Puppet code on different Operating Systems. Puppet is run in apply mode. Quick test of classes for different OS can be done by changing the [osrole](https://github.com/example42/psick-hieradata/blob/production/data/role/ostest.yaml.sample) role data (you will probably work on your own copy of the hieradata module).
  - `environments/foss`: A generic Puppet OSS setup with server and clients.
  - `environments/pe`: A generic Puppet PE setup with server and clients.
  
In each environment directory (like `psick/vagrant/environments/lab`) there are at least the following files:

  - `Vagrantfile` a symbolic link to the general shared Vagrantfile in `psick/vagrant/Vagrantfile`
  - `config.yaml` the actual configuration file of the environment. Here is possible to define which nodes have to be visible when running `vagrant status` and how they are configured
  - `README.md` an environment specific README file with specific notes about the relative Vagrant environment

### Customisations

We can customise the `Vagrant` environments in various ways:

  - Remove the ```vagrant/environments/``` directories we don't use or need.

  - Add one or more custom environments for different use cases, such as Applications developers stations, Puppet developers stations, semi-permanent test environments, continuous integration environments...

  - Customise the ```config.yaml``` file to define size, OS, role, number of each vagrant vm.

  - Customise eventually the same `Vagrantfile` for our own needs (not recommended if local control-repo structure is supposed to be aligned to upstream psick).

### Editing config.yaml

The ```config.yaml``` file is used by the local `Vagrantfile` to customise easily the VMs we want to use.

Here we can set the general settings valid for all the VM:

    vm:
      memory: 512            # Default memory in MB to use for all the VMs (set here a sane common default and override on nodes where needed)
      cpu: 1                 # Default number of vCPUs for the VMs
      box: centos7           # The default Vagrant box to use (from the list under `vagrant/boxes.yaml`)
      puppet_apply: true     # If to provision with puppet apply executed on the local files
      puppet_agent: false    # If to provision with puppet agent (you have to take care of setting up your Puppet Master)
      facter_external_facts: true # If to create external facts in facts.d/$fact.txt. Note 1
      facter_trusted_facts: true  # If to create trusted facts in csr_attributes.yaml. Note 1
      synced_folder_type: vboxfs  # Type of sync folders to use (default vboxfs): nfs, vboxfs

Note 1: You may want to set facts on VMS an use them in your hiera.yaml. Psick by default can set and use the following facts: env, role, zone, datacenter, application.
On the default psick's `manifests/site.pp` trusted facts like $trusted['extensions']['pp_role'] are assigned to top scope variables like $role which are then used in the default
`hiera.yaml`. Check the notes in `manifests/site.pp` for more details and notes on cohexisted of trusted d and external facts.

Manage general network settings:

    network:
      range: 10.42.45.0/24   # The network to use for VMs internal lan, shared by VMs of the same environment
      ip_start_offset: 101   # The starting IP in the above range (if an ip_address is not explicitly set for a VM)
      domain: ostest.psick.io  # The DNS domain of your VMs

Manage `Puppet` related settings:

    puppet:
      version: latest        # Which version of Puppet to use
      env: test              # Adds a fact called env to the VM with the given value (if vm.facter_external_facts or vm.facter_trusted_facts are true)
      zone: local            # Adds a fact called zone to the VM with the given value
      role: ostest           # Adds a fact called role to the VM. You will probably override this in each node
      datacenter: london     # Adds a fact called datacenter to eventually use in hiera.yaml
      application: website   # Adds a fact called application to eventually use in hiera.yaml 
      install_oss: false     # If to install Puppet OSS agent on the VMS
      install_pe: true       # If to install Puppet Enterprise agent on the VMS (vagrant-pe_build plugin needed)
      master_vm:  puppet.example.com    # Name of the VM which play as Puppet server for the others
      master_fqdn: 'puppet.example.com' # FQDN of the Puppet server to use with puppet agent
      master_ip: '10.42.43.101'         # IP of the Puppet server to use with puppet agent
      link_controlrepo: false     # Add a link for a Puppet environment to the development control-repo
      environment: production     # Puppet environment to link to local control-repo

Some settings are specific for Puppet Enterprise (in PE based setup the vagrant-pe_build plugin is needed):

      pe_version: '2019.1.0'         # Version of PE to install on the puppet server. See Note 2
      pe_download_root: 'https://s3.amazonaws.com/pe-builds/released/2019.1.0' # Download base url. See Note 2
      pe_verbose: true               # If to show PE installation output
      pe_relocate_manifests: false   # If to relocate manifests and module dir. Probably needed when environment: production

Note 2: when changing the version, change also the download_root unless you have a custom one. For locally downloaded files, for example, you can place something like: `pe_download_root: 'file:///Users/al/Downloads'` but when the upstream URL (on S3) is used then update pe_version and pe_download_root with the same version number.

Some other settings about related to Vagrant behaviour:

    vagrant:
      hostmanager.enable: true # If to enable hostmanager plugin to automatically update /etc/hosts on VMs and eventually host
      hostmanager.manage_host: false # If /etc/hosts is updated automatically also on the host
      multi_user: false # If to enable the ability of having different users using psick vagrant environments on the same host (VMs names must be unique on the host, with this setting the user name is added to them)
      vm_provider: virtualbox # (Default and only one actually tested). What vagrant provider to use for your VMs. Can be overridden for each node.
      docker_image: puppet/puppet-agent-ubuntu # The docker image to use if vm_provider is set to docker. Can be overridden for each node.

Define the nodes list (as shown in ```vagrant status```) for each node is possible to override general settings defined in the vm, puppet, vagrant and network sections:

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

The box names which can be used are the ones defined in the common `vagrant/boxes.yaml` file.

