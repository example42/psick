# Vagrant environment based on Puppet Enterprise and GitLab

This is a demo environment for PE and GitLab integration.

It's derived from vagrant/environment/pe and adapted for demo purposes.

Edit ```config.yaml``` to customise.

## Setup

This demo environment provides:

  - a Puppet Enterprise server
  - a GitLab server
  - one or more GitLab CI runners

### Prerequisites

    # Ensure you have the basic prerequisites
    cd <this-control-repo-dir>
    bin/setup.sh

    # For PE setup you need the pe_build plugin
    vagrant plugin install vagrant-pe_build

    cd vagrant/environment/pe_demo

    # Show available Vagrant machines
    vagrant status

    # Customise them, eventually updating the PE version to use
    vi config.yaml


### Puppet Enterprise All in One server setup

    # Start the PE all in one server. The first time, take a coffe, it .
    # It will download PE tarball, install it and run puppet agent 
    vagrant up puppet.demo
    vagrant reload puppet.demo   # In case of errors. See Note 1
    vagrant provision puppet.demo # See Notes

Now you should be able to access the PE console from your host.

Browse to **https://127.0.0.1:1743**
Login: **admin**
Password: **puppetlabs**

For testing purposes it makes sense to leave to all the clients the possibility to set their own environment.
This can can done on PE gui clicking on Nodes -> Classification -> Production environment -> Remove on the rule than matches all names.
Then a similar rule should be added for the Agent-specified environment, in this way we will be able, from within a Vagrant VM to test directly our local code with:

    root@vm# puppet agent -t --environment=host

If you want to keep your nodes pointing to the host environment without switching back to production, you can do that via PE console or by running Puppet only on demans, from the local vm:

    root@vm# puppet agent --enable ; puppet agent -t --environment=host ; puppet agent --disable


#### Notes

Note 1: The first time a new PE tarball is downloaded from the net you may have an error as what follows, when provisioning the puppet:

    bash: line 2: /vagrant/.pe_build/puppet-enterprise-2016.2.1-el-7-x86_64/puppet-enterprise-installer: No such file or directory

It looks like the newly downloaded PE tarball, placed in the ```.pe_build``` directory of this Vagrant environment, is not immediately available on the VM under its ```/vagrant``` directory.

If the PE installation files are already in place when you vagrant up the puppet, you won't have this error, so the quick solution is (the first time you create the puppet.demo vm):

    vagrant up puppet.demo # It fails if ```.pe_build``` doesn't contain the installation files for your PE version
    vagrant reload puppet.demo # Machines reloads and this times mounts ```/vagrant``` with all the expected files
    vagrant provision puppet.demo # Do the real provisioning: it should install PE and run puppet agent with no errors


Note 2: It's recommended to run this Vagrant environment on hosts that have at least 16 Gb or RAM. Edit ```config.yaml``` to tune the memory to allocate to the VM.


### Gitlab server setup

    Once the PE installation is up an running and you have completed the steps above you can start the GitLab VM:

    vagrant up git.demo

This environments also provides a fairly evoluted integration with GitLab:

  - The VM git is provisioned with an all-in-one installation of Gitlab. To access it, once the machine is provisioned, browse to **https://localhost:1744** (use a hostname different that the one used for PE to avoid certs errors on your browser when trying to reach two different sites, with different, self signed, certs, for the same hostname) errors on your browser when trying to reach two different sites, with different, self signed, certs, for the same hostname).
    You have to make your first login and create your user.

  - The VM cirunner is provisioned with GitLab runner and the tools needed to run the automated tests defined in the ```.gitlab-ci.yml``` file of this project.

You can setup, more or less manually, a fully automated CI with Pipelines on GitLab trigger Puppet code deployments.

In such environments you can configure, via PE console, nodes to run with agent specified environment and then test the code you are currently working on, on your host, directly via the PE Puppet master VM, using the specifal ```host``` environment:

    # Run Puppet agent using the control-repo environment on your host
    agent# puppet agent -t --environment=host

    # Run Puppet using any other branch named environment deployed via Code Manager
    agent# puppet agent -t --environment=$branch


