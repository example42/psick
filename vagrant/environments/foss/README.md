# Vagrant environment based on Puppet Open Source

In this Vagrant environment machines are provisioned with Puppet Open Source.

By default you have at disposal the ```puppet``` machine, who has a POS allinone installation, and other VMs for other roles, which use puppet agent on the puppet VM (which compiles catalogs based on code and data on this control-repo).

Edit ```config.yaml``` in this directory to customise the VMs to test, the Puppet Open Source version to use and how you want your Vagrant environment to be.

To work in this Vagrant environment:

    cd <your-control-repo-dir>
    cd vagrant/environment/pos

    # Show available Vagrant machines
    vagrant status

    # Customise them, eventually updating the POS version to use
    vi config.yaml

    # Start the puppet. It will install Puppet Open Source from Puppet repositories
    vagrant up puppet.lan
    vagrant reload puppet.lan
    vagrant provison puppet.lan

    # Then start the other VM you want to test.
    # They will run puppet agent pointing to the puppet vm
    vagrant up [vm]               # See Note 1


Note 1: It's recommended to run this Vagrant environment on hosts that have at least 8 Gb of RAM. Edit ```config.yaml``` to tune the memory to allocate to the VM.

There is no web frontend for reporting at the moment. We are working on bootstrapping puppetboard onto the POS master.

