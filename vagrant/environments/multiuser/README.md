# Vagrant environment for multi-user setup

This Vagrant environment is intended to be used on large Vagrant hosts where different users
test their code on their own vagrant vms.

A central Puppet server, configured via master_fqdn rant environment.
In order to be able to use the local user Puppet code, the Puppet server ideally should run
on the same Vagrant host where the different vms are running.

Edit ```config.yaml``` in this directory to customise the VMs to test.

    puppet:
      master_vm: ''      # Puppetserver is not a local VM
      master_fqdn: 'puppet.lab.psick.io'   # FQDN of the Puppet server to use with puppet agent
      purge_via_ssh: false        # Use ssh when purging puppet nodes from master_fqdn Puppet server

    network:
      domain: pe.psick.io    # Name of DNS domain for the created machines
      ports_offset_map:      # A map of users and relevant host port forwarding offset 
        al: 10000
        lab: 20000


To work in this Vagrant environment:

    cd <your-control-repo-dir>
    cd vagrant/environment/multiuser

    # Show available Vagrant machines
    vagrant status

    # Customise them
    vi config.yaml

    # Set hiera data to test directly onm your own vm yaml file
    cd <your-control-repo-dir>
    vi hieradata/host/<user>-<hostname>.yaml

