# Vagrant environment of bare OS machines

This Vagrant environment is similar to ostest, in terms of choices of OS, 
bust provaide bare installations, without setup of any kind and without mount
of local control-repo directory on the VM guest.

Edit ```config.yaml``` in this directory to customise the VMs to test.

To work in this Vagrant environment:

    cd <your-control-repo-dir>
    cd vagrant/environment/bare

    # Show available Vagrant machines
    vagrant status

    # Customise them
    vi config.yaml

    # Define and parametrise the Puppet classes to test
    cd <your-control-repo-dir>
    vi hieradata/role/bare.yaml


