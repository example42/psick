# Vagrant environment based on Puppet Open Source

In this Vagrant environment machines are provisioned with Puppet Open Source.

By default you have at disposal the ```puppet``` machine, who has a POS allinone installation, and other VMs for other roles, which use puppet agent on the puppet VM (which compiles catalogs based on code and data on this control-repo).

Edit ```config.yaml``` in this directory to customise the VMs to test, the Puppet Open Source version to use and how you want your Vagrant environment to be.  
You can give a look to [config.yaml documentation here](/docs/vagrant.md#customisations).

To work in this Vagrant environment:

    cd <your-control-repo-dir>

    # Download or refresh modules listed in Puppetfile if needed
    r10k puppetfile install -v

    # Move to vagrant foss environment
    cd vagrant/environment/foss

    # Show available Vagrant machines
    vagrant status

    # Customise them, eventually updating the version to use
    vi config.yaml

    # Start the puppet VM. It will install Puppet Open Source from Puppet repositories
    vagrant up puppet.foss.psick.io

    # You might need to provision multiple times, at the beginning
    vagrant provision puppet.foss.psick.io

    # Then start the other VM you want to test.
    # They will run puppet agent pointing to the puppet vm
    vagrant up [vm]

Note 1: It's recommended to run this Vagrant environment on hosts that have at least 8 Gb of RAM. Edit ```config.yaml``` to tune the memory to allocate to the VM.

There is no web frontend for reporting at the moment. We are working on bootstrapping puppetboard onto the POS master.
