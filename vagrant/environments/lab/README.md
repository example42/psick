# Lab Vagrant environment based on Puppet Enterprise and GitLab

This Vagrant environment is used to test PSICK code in a lab with a Puppet Enterprise (10 nodes evaluation) [instance](https://puppet.lab.psick.io) serving the local Puppet code to various client VMs.

Among them there's a GitLab [server](https://git.lab.psick.io/) and the relevant GitLab runner.

[Read Only] access to these servers is public, check the links here and in the main README.md to access these services on lab.psick.io.

## Setup

This lab.psick.io environment provides:

  - a Puppet Enterprise server
  - a GitLab server
  - one or more GitLab CI runners
  - various clients with different roles for testing

Note that you need an host of at least 8Gb of RAM (better 16 or more) for this environment.


### Prerequisites

If you have just downloaded PSICK, ensure you have made the setup of the basic prerequisites

    cd <this-control-repo-dir>
    bin/setup.sh

For Puppet Enterprise setup you need the pe_build plugin, for handling hostnames effortlessly you need the hostmanager one and you need the vbguest one to install VirtualBox Additions on the VM in order to mount the local control-repo files on the Puppet server VM:

    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-pe_build
    vagrant plugin install vagrant-hostmanager

    cd vagrant/environment/lab

Show available Vagrant machines

    vagrant status

Customise them, eventually updating the PE version to use

    vi config.yaml


### Puppet Enterprise All in One server setup

Start the PE all in one server. The first time, take a coffe, it. It will download PE tarball, install it and run puppet agent 

    vagrant up puppet.lab.psick.io
    vagrant reload puppet.lab.psick.io    # See Note 1
    vagrant provision puppet.lab.psick.io

Now you should be able to access the PE console from your host.

Browse to **https://127.0.0.1:1443**
Login: **admin**
Password: **puppetlabs**

Now you can create a user dedicated to Puppet deployments:

  - Click: Access Control -> Users -> Add local user (Specify Full Name and login. Here we used: deployer)
  - Click: User -> Edit user -> Generate Password reset
  - Copy the link for password reset and open it with a browser to the the user password.
  - To assign at least deployment permissions to the user click User Roles -> Code Deployers -> Add user (Select from menu the User name)

The PE username and password you've set have to be provided as parameters for the psick::puppet::pe_code_manager class, as follows:

    psick::puppet::pe_code_manager::pe_user: 'deployer'
    psick::puppet::pe_code_manager::pe_password: 'deployer'

For testing purposes it makes sense to leave to all the clients the possibility to set their own environment.
This can can done on PE gui clicking on Nodes -> Classification -> Production environment -> Remove on the rule than matches all names.
Then a similar rule should be added for the Agent-specified environment, in this way we will be able, from within a Vagrant VM to test directly our local code with:

    root@vm# puppet agent -t --environment=host

Note, that the current environent is saved everytime to ```puppet.conf```due to this setting in ```hieradata/zone/lab.yaml```:

    psick::puppet::pe_agent::manage_environment: true

#### Notes

Note 1: The first time a new PE tarball is downloaded from the net you may have an error as what follows, when provisioning the puppet:

    bash: line 2: /vagrant/.pe_build/puppet-enterprise-2016.2.1-el-7-x86_64/puppet-enterprise-installer: No such file or directory

It looks like the newly downloaded PE tarball, placed in the ```.pe_build``` directory of this Vagrant environment, is not immediately available on the VM under its ```/vagrant``` directory.

If the PE installation files are already in place when you vagrant up the puppet, you won't have this error, so the quick solution is (the very first time you use a new PE version):

    vagrant up puppet.lab.psick.io # It fails if ```.pe_build``` doesn't contain the installation files for your PE version
    vagrant reload puppet.lab.psick.io # Machines reloads and this times mounts ```/vagrant``` with all the expected files
    vagrant provision puppet.lab.psick.io # Do the real provisioning: it should install PE and run puppet agent with no errors


Note 2: It's recommended to run this Vagrant environment on hosts that have at least 16 Gb or RAM. Edit ```config.yaml``` to tune the memory to allocate to the VM.


#### Gitlab server setup

Once the PE installation is up an running and you have completed the steps above, you can start to setup the GitLab server:

    vagrant up git.lab.psick.io

This environments also provides a fairly evoluted integration with GitLab:

  - The VM git is provisioned with an all-in-one installation of Gitlab. To access it, once the machine is provisioned, browse to **https://localhost:1444** (use a hostname different that the one used for PE to avoid certs errors on your browser when trying to reach two different sites, with different, self signed, certs, for the same hostname) errors on your browser when trying to reach two different sites, with different, self signed, certs, for the same hostname).
    You have to make your first login and create your user.

  - The VM cirunner is provisioned with GitLab runner and the tools needed to run the automated tests defined in the ```.gitlab-ci.yml``` file of this project.

You can setup, more or less manually, a fully automated CI with Pipelines on GitLab trigger Puppet code deployments.

In such environments you can configure, via PE console, nodes to run with agent specified environment and then test the code you are currently working on, on your host, directly via the PE Puppet master VM, using the specifal ```host``` environment:

    # Run Puppet agent using the control-repo environment on your host
    agent# puppet agent -t --environment=host

    # Run Puppet using any other branch named environment deployed via Code Manager
    agent# puppet agent -t --environment=$branch


