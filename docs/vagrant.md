# example42 control-repo and Vagrant

This contro-repo contains different Vagrant environments for different purposes.

You can work with then directly issuing ```vagrant``` commands in ```vagrant/environments/<env_name>``` or via Fabric from the main repo dir.

### Vagrant Frabric tasks

Run vagrant status on all the available Vagrant environments

    fab vagrant.all_status

Run vagrant status on a specific Vagrant environment

    fab vagrant.all_status:ostest

Run vagrant provision on all the running vm of a Vagrant environment:

    fab vagrant.provision:env=puppetinfra

Run vagrant up on the given vm:

    fab vagrant.up:vm=dev-local-docker-build-01


### Prerequisites: 

For a correct setup of the Vagrant environment you need:

  - Vagrant locally installed

  - Virtual Box locally installed

  - Possibly some extra Vagrant plugins:

        vagrant plugin install vagrant-cachier
        vagrant plugin install vagrant-vbguest
        vagrant plugin install vagrant-hostmanager

 
