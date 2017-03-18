## Using and understanding this control-repo

The control-repo you find here is what we consider a starting point for a state of the art general purpose Puppet setup.

It's based on a nodeless classification, driven by 3 top scope variables:

  - ```$::role``` - Defines the nodes' role
  - ```$::env``` - Defines the nodes' operational environment
  - ```$::zone``` - Defines the datacenter or region or segment of an infrastructure (optional)

These variables are used in the Hiera's hierarchy (check ```bin/hiera3.yaml```) and should be enough to classify univocally any node in a averagely complex infrastructure. Here they are set as external facts (you'll need to set them when provisioning your nodes, as it's done in the Vagrant environment).

Such an approach can be easily adapted to any other logic and environment, for example, you can use an External Node Classifier (ENC) like Puppet Enterprise or The Foreman and manage there how your nodes are classified.

The manifests file, ```manifests/site.pp``` sets some resource defaults, includes a baseline profile according to the underlying OS and uses hiera to define what profiles have to be included in each role (a more traditional alternative, based on role classes, is possible).

All the Hiera data is in ```hieradata``` , the file ```bin/hiera3.yaml``` shows a possible hierarchy design and uses ```hiera-eyaml``` as backend for keys encryption (no key is currently encrypted, because we are not shipping the generated private key (it's in .gitignore).
You will have to regenerate your hiera-eyaml keys (run, from the main repo dir, ```eyaml createkeys```).

On your Puppet server, if you want to keep hiera.yaml information in the control-repo you have to link it:

    # For hiera 3 format (classic)
    ln -sf /etc/puppetlabs/code/environments/production/bin/hiera3.yaml /etc/puppetlabs/puppet/hiera.yaml
    # For hiera 5 format
    ln -sf /etc/puppetlabs/code/environments/production/bin/hiera5.yaml /etc/puppetlabs/puppet/hiera.yaml


In the ```site``` directory there are local "not public" modules. Basically our profiles and some role examples.

For specifically there's the **profile** modules under ```site/profile``` with a large amount of sample profiles for several common and not so sommon tasks.

There's also a **tools** module, under ```site/tools``` which contains defines useful to manage common resources on a system.

In the ```modules``` directory are placed the public modules, as defined in the ```Puppetfile``` and installed via r10k or librarian-puppet.

The ```vagrant``` directory contains different Vagrant environments with the relevant toolset that can be used to test the same control-repo.
They are fully customizable by editing the ```config.yaml``` file in each Vagrant environment.

Files for building Docker images locally are under the ```docker``` directory.

The ```skeleton``` directory contains a module skeleton you can use, and modify, to generate new modules based on the skeleton structure.
 
Documentation is stored under ```docs```, while the ```bin``` directory contains several scirpts fot various purposes. Most of them can be invoked via Fabric, as configured in the ```*.py``` files in the main directory.


