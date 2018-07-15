## Trusted facts

Extensions to a node certificate can de defined for each `Puppet` managed node in order to define informations that **can't be changed** unless the same node certificate is recreated.

These settings are defined `trusted facts`, for this reason and are the most secure way to set facts on a node which don't rely of some computation but just define some characteristics of the node itself (as its `role`, operational `environment` or other).

**Before** the first execution of `Puppet` on the node edit ```/etc/puppetlabs/puppet/csr_attributes.yaml``` with a content like:

    ---
      extension_requests:
        pp_role: 'fe'
        pp_environment: 'devel'
        pp_datacenter: 'main'
        pp_application: 'voicemail'

The first `Puppet` run should be done after this file has been generated.

Once created, `trusted facts` can be accessed in `Puppet code` with a syntax like:

    $trusted['extensions']['pp_role']

**NOTE:** that once a `trusted fact` is set, that can't be changed unless the client's certificate is recreated. This means, for example, that before changing the environment of a server (if ever needed) a (eventually manual) client re-certification has to be done.

In case of SSL errors always usual procedures apply:

  - Check times on client and server are synced
  - Eventually clean old certs with same name on client and server
  - Google

For more information: [SSL configuration: CSR attributes and certificate extensions](https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html)

**NOTE:** that once a `trusted fact` is set, that can't be changed unless the client's certificate is recreated. This means, for example, that before changing the environment of a server (if ever needed) a (eventually manual) client re-certification has to be done.

In this `control-repo` if `trusted facts` such facts are defined, they are used to populate `top scope` variables which are then used in ```hiera.yaml``` hierarchy.

The `top scope` variables are defined in ```manifests/site.pp``` as follows:

    if $trusted['extensions']['pp_role'] {
      $role = $trusted['extensions']['pp_role']
    }
    if $trusted['extensions']['pp_environment'] {
      $env = $trusted['extensions']['pp_environment']
    }
    if $trusted['extensions']['pp_datacenter'] {
      $zone = $trusted['extensions']['pp_datacenter']
    }

In ```hiera.yaml``` are then used these variables in the sample hierarchy:

    paths:
      - "nodes/%{trusted.certname}.yaml"
      - "role/%{::role}-%{::env}.yaml"
      - "role/%{::role}.yaml"
      - "zone/%{::zone}.yaml"
      - "common.yaml"
