## Using and understanding this control-repo

The default design of this control-repo is based on a nodeless classification, driven by top scope variables like these:

  - ```$::role``` - Defines the nodes' role
  - ```$::env``` - Defines the nodes' operational environment
  - ```$::zone``` - Defines the datacenter or region or segment of an infrastructure (optional)

Variable names and area of interest can be adapted, according to out hierarchy in ```hiera.yaml``` but in any case such variable have to be set.

There are different ways to set top scope variables:

  - As **[trusted facts](trusted_facts.md)**, set before Puppet installation

  - As **[external facts](trusted_fact.s)**, writing the relevant files under ```/etc/puppetlabs/facter/facts.d```

  - As global parameters set in a **ENC** (such as Puppet Enterprise or The Foreman).

  - In **manifests/site.pp** as result of the parsing of the hostname or other facts.

The latter case is possible when we have hostnames with a fixed pattern which contains information about the role, env, zone or whatever needed grouping.

For example if we have nodes with a naming pattern like: $role-$id-$env.$::domain (ie: fe-01-test.example42.com) we can have set top scope variables in ```manifests/site.pp``` (outside any class or node statement):

    $node_array = split($::hostname,'-')
    $role = $node_array[0]
    $id = $node_array[1]
    $env = $node_array[2]

These variables are used in the Hiera's hierarchy (check ```hiera.yaml```) and should be enough to classify univocally any node in a averagely complex infrastructure. Here they are set as external facts (you'll need to set them when provisioning your nodes, as it's done in the Vagrant environment).

Such an approach can be easily adapted to any other logic and environment, for example, you can use an External Node Classifier (ENC) like Puppet Enterprise or The Foreman and manage there how your nodes are classified.

The manifests file, ```manifests/site.pp``` sets some resource defaults, includes a baseline profile according to the underlying OS and uses hiera to define what profiles have to be included in each role (a more traditional alternative, based on role classes, is possible).

All the Hiera data is in ```hieradata``` , the file ```hiera.yaml``` shows a possible hierarchy design and uses ```hiera-eyaml``` as backend for keys encryption (no key is currently encrypted, because we are not shipping the generated private key (it's in .gitignore).

You will have to regenerate your hiera-eyaml keys (run, from the main repo dir, ```eyaml createkeys```).

On your Puppet server, if you want to keep hiera.yaml information in the control-repo you have to link it:

    # For hiera 3 format (classic)
    ln -sf /etc/puppetlabs/code/environments/production/hiera3.yaml /etc/puppetlabs/puppet/hiera.yaml
    # For hiera 5 format
    ln -sf /etc/puppetlabs/code/environments/production/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml

### Setting and customise variables used in Hiera hierarchy

Feel free to adapt these variables names and kind to our own needs: we may want to define different variable names to use in Hier

  - As *trusted facts*, as outlined here

  - As *external facts*, writing the relevant files under ```/etc/puppetlabs/facter/facts.d```

  - As global parameters set in a ```ENC``` (such as Puppet Enterprise or The Foreman).

  - In *manifests/site.pp* as result of the parsing of the hostname.

The latter case is possible when we have hostnames with a fixed pattern which contains information about the role, env, zone or w

For example if we have nodes with a naming pattern like: $role-$id-$env.$::domain (ie: fe-01-test.example42.com) we can have set

    $node_array = split($::hostname,'-')
    $role = $node_array[0]
    $id = $node_array[1]
    $env = $node_array[2]



