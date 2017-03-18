# Vagrant environment for Operating Systems test

This Vagrant environment allows you to test the code in your local copy of the control-repo 
on different Vagrant boxes for different Operating Systems.

Edit ```config.yaml``` in this directory to customise the VMs to test.

To work in this Vagrant environment:

    cd <your-control-repo-dir>
    cd vagrant/environment/ostest

    # Show available Vagrant machines
    vagrant status

    # Customise them
    vi config.yaml

    # Define and parametrise the Puppet classes to test
    cd <your-control-repo-dir>
    vi hieradata/role/ostest.yaml


