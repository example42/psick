# Setting trusted facts

Extensions to a node certificate can de defined for each Puppet managed node in order to define informations that can't be changed unless the same node certificate is recreated.

These settings are defined trusted facts, for this reason and are the most secure wa to set facts on a node which don't rely of some computation but just define some characteristics of the node itself (as its role, operational environment or other).

**Before** the first execution of Puppet edit ```/etc/puppetlabs/puppet/csr_attributes.yaml``` with a content like:

    ---
      extension_requests:
        pp_role: 'fe'
        pp_environment: 'devel'
        pp_datacenter: 'main'
        pp_application: 'voicemail'

The first Puppet run should be done after this file has been generated.

Once created trusted facts can be accessed in Puppet code with a syntax like: ```$trusted['extensions']['pp_role']```.

Note that once a trusted fact is set, that can't be changed unless the client's certificate is recreated. This means, for example, that before changing the environment of a server (if ever needed) a (eventually manual) client re-certification has to be done. 

In case of SSL errors always usual procedures apply:

  - Check times on client and server are synced
  - Eventually clean old certs with same name on client and server
  - Google

For more information: [SSL configuration: CSR attributes and certificate extensions](https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html)

Note that once a trusted fact is set, that can't be changed unless the client's certificate is recreated. This means, for example, that before changing the environment of a server (if ever needed) a (eventually manual) client re-certification has to be done.

In this control-repo if trusted facts such facts are defined, they are used to populate top scope variables which are then used in hiera.yaml hierachy.

The top scope variables are defined in ```manifests/site.pp``` as follows:

    if $trusted['extensions']['pp_role'] {
      $role = $trusted['extensions']['pp_role']
    }
    if $trusted['extensions']['pp_environment'] {
      $env = $trusted['extensions']['pp_environment']
    }
    if $trusted['extensions']['pp_datacenter'] {
      $zone = $trusted['extensions']['pp_datacenter']
    }

In ```bin/hiera3.yaml``` are then used these variables in the sample hierarchy:

    :hierarchy:
      - "hostname/%{::trusted.certname}"
      - "role/%{::role}-%{::env}"
      - "role/%{::role}"
      - "zone/%{::zone}"
      - common

### Setting and customise variables used in Hiera hierarchy

Feel free to adapt these variables names and kind to your own needs: you may want to define different variable names to use in Hiera hierarchy for different purposes and you may define their values in different ways, such as:

  - As *trusted facts*, as outlined here

  - As *external facts*, writing, possibly during provisioning, the relevant files under ```/etc/puppetlabs/facter/facts.d```

  - As global parameters set in a ```ENC``` (such as Puppet Enterprise or The Foreman).

  - In *manifests/site.pp* as result of the parsing of the hostname.

The latter case is possible when we have hostnames with a fixed pattern which contains information about the role, env, zone or whatever of a node.

For example if we have nodes with a naming pattern like: $role-$id-$env.$::domain (ie: fe-01-test.example42.com) we can have set top scope variables in our ```manifests/site.pp``` with something like:

    $node_array = split($::hostname,'-')
    $role = $node_array[0]
    $id = $node_array[1]
    $env = $node_array[2]


