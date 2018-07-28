- [Hiera](#hiera)
    - [Hiera configuration: hiera.yaml](#hiera-configuration-hierayaml)
    - [Environment and module data](#environment-and-module-data)
    - [The lookup command](#the-lookup-command)

## Hiera

[Hiera](https://docs.puppet.com/hiera/) is `Puppet's` builtin key/value data lookup system, where we can store the data we use to configure our system. It has some peculiar characteristics:

  - It's hierarchical: We can configure different hierarchies of data sources and these are traversed in order to find the value of the desired key, from the level at the top, to the one at the bottom.
  This is very useful to allow granular configurations of different settings for different groups of servers

  - It has a modular backend system: data can be stored on different places, according to the used plugins, from simple `Yaml` or `Json` files, to `MongoDb`, `Mysql`, `PostgreSQL`, `Redis` and [others](https://voxpupuli.org/plugins/#hiera). In our `control-repo` we use the [Hiera-eyaml](hiera_eyaml.md) backend which uses plain [Yaml](http://yaml.org) files for data storage and allows encryption of the values of selected keys (typically the ones which contains passwords or secrets)

`Hiera` is important because it allows to assign values to the parameters of `Puppet` classes.

A parameter called ```server``` of a class called ```ntp```, for example, can be evaluated via a lookup of the `Hiera` key ```ntp::server```:

    class ntp (
      String $server = 'ntp.pool.org'
    ) { ... }

Given the above class we can override the default value for the ```server``` parameter of the class ```ntp``` with a similar entry in one of the ```.yaml``` files used in `Hiera's` hierarchies:

    ---
    ntp::server: 'time.nist.gov'

This is useful to cleanly separate our `Puppet code`, where we declare, inside classes, the resources we want to apply to our nodes, from the `data` which defines how these resources should be.

In `Puppet 4.9`, `Hiera version 5` has been introduced and this is the version we use in our `control-repo`.


### Hiera configuration: hiera.yaml

`Hiera's` configuration file (```hiera.yaml```) has changed format in version 5, here's the default, which uses the core `Yaml` backend and has only a layer called common:

    ---
    version: 5
    hierarchy:
      - name: Common              # A level of the hierarchy. They can be more using different data sources
        path: common.yaml         # The path of the file, under the datadir, where data is stored
    defaults:
      data_hash: yaml_data        # Use the YAML backend
      datadir: data               # Yaml files are stored in the data dir of our Puppet environment/control-repo

Here's the actual structure of the ```hiera.yaml``` file used in this `control-repo`, it uses the `hiera-eyaml` backend and has various levels in its hierarchy:

    ---
    version: 5
    defaults:
      datadir: data
      data_hash: yaml_data
    hierarchy:
      - name: "Eyaml hierarchy"
        lookup_key: eyaml_lookup_key # eyaml backend
        paths:
          - "nodes/%{trusted.certname}.yaml"
          - "role/%{::role}-%{::env}.yaml"
          - "role/%{::role}.yaml"
          - "zone/%{::zone}.yaml"
          - "common.yaml"
        options:
          pkcs7_private_key: /etc/puppetlabs/puppet/keys/private_key.pkcs7.pem
          pkcs7_public_key:  /etc/puppetlabs/puppet/keys/public_key.pkcs7.pem

The key infos we can get from it are:

  - The `eyaml-backend` is used (```lookup_key: eyaml_lookup_key```)

  - It's `public` and `private keys` are stored in the directory ```/etc/puppetlabs/puppet/keys/```. They have to be copied there wherever we run `Puppet` to compile a catalog which uses encrypted data: typically on the `Puppet Server`, on the `Vagrant VMs` where we use `Puppet` for local testing during development, and eventually also on the `Vagrant VMs` used in `CI`. These keys are not present in this `control-repo` (otherwise it would defy the whole concept of using encryption to protect sensitive data).

  - The `Yaml` files containing our `Hiera` data are placed in the directory data (```datadir: data```) in our `control-repo`/`Puppet environment` directory. So, for example, for production `Puppet` environment, all the `YAML` files are under ```/etc/puppetlabs/code/environments/production/data```

  - The hierarchy is based on several `paths` under the ```datadir```. Variables are used there (```%{varname}```). Hierarchy goes from the most specific path: ```nodes/%{::trusted.certname}.yaml``` which refers to a specific node to the most generic (```common.yaml```) which is used as default value for keys which are not set at higher levels.

For full reference on the format of `Hiera 5` configuration file, check the [Official Documentation](https://docs.puppet.com/puppet/latest/hiera_config_yaml_5.html)

### Environment and module data

`Hiera 4`, used from `Puppet` versions 4.3 to 4.8, introduced the possibility of defining, inside a module, the default values of each class parameter using `Hiera`.

The actual user data, outside modules, was configured by a global ```/etc/puppetlabs/puppet/hiera.yaml``` file, which defines `Hiera` configurations for every `Puppet environment`.

With `Hiera 5` is possible to have environment specific configurations, so we can have a ```hiera.yaml``` inside a environment directory which may be different for each environment:

    /etc/puppetlabs/code/environments/$environment_name/hiera.yaml

So, for the ```production environment```:

    /etc/puppetlabs/code/environments/production/hiera.yaml

This is useful to test hierarchies or backend changes before committing them to the ```production environment```.

We can have also per module configurations, so in a ```NTP module```, for example, we can have a:

    $module_path/users/hiera.yaml

with the, now familiar, version 5 syntax:

    ---
    version: 5

    defaults:
      datadir: data
      data_hash: yaml_data

    hierarchy:
      - name: "In module hierarchy"
        paths:
          - "%{facts.virtual}.yaml"
          - "%{facts.os.name}-%{facts.os.release.major}.yaml"
          - "%{facts.os.name}.yaml"
          - "%{facts.os.family}-%{facts.os.release.major}.yaml"
          - "%{facts.os.family}.yaml"
          - "common.yaml"

this refers ```.yaml``` files under the ```data``` directory of the module.

The interesting thing in this is that we have a uniform and common way to lookup for data, across the [three layers](https://docs.puppet.com/puppet/latest/hiera_layers.html): `global`, `environment` and `module`: each hierarchy of each layer is used to compose a "super hierarchy" which is traversed seamlessly.

In the module data is also possible to define the kind of lookup to perform for each class parameter.

Previously the lookup was always a "normal" one: the value returned is the one of the key found the first time while traversing the hierarchy.

Now (actually since `Hiera 4`) it's possible to specify for some parameters alternative lookup methods (for example merging all the values found across the hierarchy for the requested key). This is done in the same data files where we specify our key values, so, for example, in our ```$module_path/users/data/common.yaml``` we can have:

    lookup_options:
      # This lookup option applies to parameter 'local' of class 'users'
      users::local:
      # Merge the values found across hierarchies, instead of getting the first one
        merge:
      # Do a deep merge, useful when dealing with Hashes (to override single subkeys)
          strategy: deep                
          merge_hash_arrays: true
      # This lookup option applies to parameter 'admins' of class 'users'
      users::admins:                    
        merge:                          
      # In this case we expect an array and will merge all the values found in a single one
          strategy: unique              
      # It's even possible to define a prefix (here --) to force the removal of entries
          knockout_prefix: "--"


Note that we can use regular expressions when defining specific lookup options for some keys:

    lookup_options:
      "^profile::(.*)::(.*)_hash$":
        merge:
          strategy: deep
          knockout_prefix: "--"
      "^profile::(.*)::(.*)_list$":
        merge:
          strategy: unique
          knockout_prefix: "--"

### The lookup command

It's possible to use the ```puppet lookup``` command to query `Hiera` for a given key.

If we run this on our `Puppet Server` we can easily find out the value of a given key for the specified node:

    puppet lookup profiles --node git.lab # Looks for the profiles key on the node git.lab

If we add the ```--debug``` option we will see a lot of useful information about where and how data is looked for.

We can also use the ```lookup()``` function inside our `Puppet code`, it replaces (and **deprecates**), the old ```hiera()```, ```hiera_array()```, ```hiera_hash()``` and ```hiera_include()```.

The general syntax is:

    lookup( <NAME>, [<VALUE TYPE>], [<MERGE BEHAVIOR>], [<DEFAULT VALUE>] )

or

    lookup( [<NAME>], <OPTIONS HASH> )

Some examples follow.

Normal lookup. Same of ```hiera('ntp::user')```:

    lookup('ntp::user')

Normal lookup with default. Same of ```hiera('ntp::user','root')```:

    lookup('ntp::user','root')

Array lookup, same of ```hiera_array('ntp_servers')```:

    lookup('ntp_servers', Array, 'unique')

Deep merge lookup, same of ```hiera_hash('users')``` with ```deep_merge``` set to true:

    lookup('users', Hash, 'deep')

Include classes found on `Hiera`, same of ```hiera_include('classes')```

    lookup('classes', Array[String], 'unique').include

All the above examples can be written in an expanded way. In the following example an array is merged across the hierarchies with the option to use the ```"--"``` prefix to **exclude** specific entries:

    lookup({
      'name'  => 'ntp_servers',
      'merge' => {
        'strategy'        => 'unique',
        'knockout_prefix' => '--',
      },
    })

Check the [official reference](https://docs.puppet.com/puppet/latest/function.html#lookup) for all the options available for the lookup function.
