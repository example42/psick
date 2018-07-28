## Using and understanding this control-repo

The default design of this `control-repo` is based on a nodeless classification, driven by `top scope` variables like these:

  - ```$::role``` - Defines the nodes' `role`
  - ```$::env```  - Defines the nodes' operational `environment`
  - ```$::zone``` - Defines the `datacenter` or `region`, or `segment` of an infrastructure **(optional)**

Variable names and area of interest can be adapted, according to our hierarchy in ```hiera.yaml``` but in any case such variables **have to be set** in some ways.

There are different ways to set `top scope` variables:

  - As **[trusted facts](trusted_facts.md)**, set on the client **before** `Puppet` installation

  - As **[external facts](external_facts.md)**, writing the relevant files on the client under ```/etc/puppetlabs/facter/facts.d```

  - As global parameters set in a [**ENC**](https://puppet.com/docs/puppet/latest/nodes_external.html) (such as [Puppet Enterprise](https://puppet.com/products/puppet-enterprise) or [The Foreman](https://www.theforeman.org/)).

  - On `Puppet Server` in ```manifests/site.pp``` as result of the parsing of the hostname or other facts.

The latter case is possible when we have hostnames with a fixed pattern which contains information about the `role`, `env`, `zone` or whatever needed for grouping.

For example if we have nodes with a naming pattern like: ```$role-$id-$env.$::domain``` (ie: ```fe-01-test.example42.com```) we can have set `top scope` variables in ```manifests/site.pp``` (outside any class or node statement):

    $node_array = split($::hostname,'-')
    $role = $node_array[0]
    $id = $node_array[1]
    $env = $node_array[2]

These variables are used in the `Hiera's` hierarchy (check ```hiera.yaml```) and should be enough to classify univocally any node in a averagely complex infrastructure. Here they are set as `external facts` (you'll need to set them when provisioning your nodes, as it's done in the `Vagrant` environment).

Such an approach can be easily adapted to any other logic and environment, for example, you can use an `External Node Classifier` (ENC) like `Puppet Enterprise` or `The Foreman` and manage there how your nodes are classified.

The manifests file, ```manifests/site.pp``` sets some resource defaults and just includes the `psick` module, which manages nodes classification and provides profiles for common use cases.

All the `Hiera data` is in ```hieradata``` , the file ```hiera.yaml``` shows a possible hierarchy design and uses `hiera-eyaml` as backend for keys encryption (no key is currently encrypted, because we are not shipping the generated private key (it's in ```.gitignore```).

You will have to regenerate your `hiera-eyaml` keys (run, from the main repo dir, ```eyaml createkeys```).
