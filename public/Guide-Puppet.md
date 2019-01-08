puppet.md
hiera.md
hiera_eyaml.md
trusted_facts.md
external_facts.md
pe_console.md
## Introduction to Puppet

Puppet features a **declarative Domain Specific Language (DSL)**, which expresses the **desired state** and properties of the managed resources.

**Resources** can be any component of a system, for example, packages to install, services to start, files to manage, users to create, and also custom and specific resources such as MySQL grants, Apache virtual hosts, but also Network interfaces, AWS instances, Storage volumes and so on.

Puppet code is written in **manifests**, which are simple text files with a **.pp** extension.

Resources can be grouped in **classes** (do not consider them as classes as in OOP; they aren't). Classes and all the files needed to define the required configurations are generally placed in **modules**, which are directories structured in a standard way that are supposed to manage specific applications or a system's features (there are modules to manage Apache, MySQL, sudo, sysctl, networking, and so on).

When Puppet is executed, it first runs **facter**, a companion application, which gathers a series of variables about the system (the IP address, the hostname, the operating system, the MAC address, and so on), which are called **facts***, and are sent to the Master.

Facts and user defined variables can be used in manifests to manage how and what resources to provide to the clients.

When the Master receives a connection, then it looks in its manifests (starting from the the files in ```/etc/puppetlabs/code/environments/production/manifests/site.pp```) what resources have to be applied for that client host, also called a node.

The Master parses all the DSL code and produces a **catalog** that is sent back to the client (in JSON PSON format). The production of the catalog is often referred to as catalog **compilation**.

Once the client receives the catalog, it starts to apply all the resources declared there, irrespective of whether packages are installed (or removed), services have started, configuration  files are created or changed, and so on. The same catalog can be applied multiple times; if there are changes on a managed resource (for example, a manual modification of a configuration file), they are reverted to the state defined by Puppet; if the system's resources are already at the desired state, nothing happens.
This property is called **idempotence** and is at the root of the Puppet declarative model. Since it defines the desired state of a system, it must operate in a way that ensures that this state is obtained wherever the starting conditions and the number of times Puppet is applied.


### Anatomy of a Puppet run

In normal setups Puppet follows a Client-Server paradigm, on clients it runs, as ```root``` the **Puppet Agent** service, which connects to the **Puppet Master**. All the communication is done using REST-like API calls on an SSL socket; basically, it's all **HTTPS** traffic from clients to the server's port **8140/TCP**.

The first time we execute Puppet on a node, a x509 **certificate** is created and then the Puppet Master is contacted in order to retrieve the node's catalog. The client's certificate has to be accepted (signed) by the server, using its own local Certification Authority.

A typical Puppet run is composed of different phases. It's important to know them in order to troubleshoot problems:

  - Execute Puppet on a root shell on the client:

        client# puppet agent -t

  - Modules' plugins (whatever is present in the ```lib``` dir of a module) are synced to the node. We will see a message like:

        [client] Info: Retrieving plugin

  - The client runs facter and sends its facts to the Master. The client output looks like:

        [client] Info: Loading facts in /var/lib/puppet/lib/facter/... [...]

  - The Master looks for the client's certname (by default the fqdn) in its nodes' list.

  - The Master compiles the catalog for the client using its facts and the Puppet code and data it. On Puppet Master logs an entry like this will be added:

        [server] Compiled catalog for <client> in environment production in 8.22 seconds

  If there are syntax errors in the processed Puppet code, they are exposed here, and the process terminates; otherwise, the server sends the catalog to the client. On the client a text like this will be displayed:

        [client] Info: Caching catalog for <client>

  The client receives the catalog and starts to apply it locally. If there are dependency loops, the catalog can't be applied and the whole run fails. If not the client will start to apply the resources present in the catalog, beginning with a message like:

        [client] Info: Applying configuration version '1355353107'

  - All changes to the system are shown on stdout or in logs. If there are errors they are relevant to specific resources but do not block the application of other resources (unless they depend on the failed ones, in those cases a message mentioning ```Skipping because of failed dependencies``` will be shown.

  - At the end of the Puppet run, the client sends to the server a report of what has been changed. Client output:

        [client] Finished catalog run in 13.78 seconds

  - The server sends the report to a report collector (typically PuppetDB) for storage and later querying.

### Learning resources

Useful resources to start learning Puppet:

  - The website of [Puppet](http://puppet.com), the company behind
  - The official [Puppet Documentation site](http://docs.puppet.com/) -
  - [The Learning VM](https://puppet.com/download-learning-vm), based on Puppet Enterprise, for a guided tour in Puppet world
  - A list of the available [Puppet Books](https://puppet.com/resources/books)

If we have questions to ask about Puppet usage we can use these:

  - All the [Puppet Community](http://puppet.com/community/overview/) references
  - [Ask Puppet](http://ask.puppet.com/), the official Q&A site
  - The discussion groups on Google Groups: [puppet-users](https://groups.google.com/forum/#!forum/puppet-users), [puppet-dev](https://groups.google.com/forum/#!forum/puppet-dev), [puppet-security-announce](https://groups.google.com/forum/#!forum/puppet-security-announce)
  - The IRC #puppet channel on [Freenode](http://webchat.freenode.net/?channels=puppet)
  - The [Slack](https://slack.puppet.com/) Puppet channels

To explore and use existing Puppet code:

  - Puppet modules on [Module Forge](http://forge.puppet.com)
  - Puppet modules on [GitHub](https://github.com/search?q=puppet)

To inform ourselves about what happens in Puppet World

  - [Planet Puppet](http://www.planetpuppet.org/) - Puppet blogosphere
  - The [PuppetConf](http://www.puppetconf.com) website
  - The ongoing [PuppetCamps]() all over the world

To find more and deeper information:

  - [Puppet Labs tickets](https://tickets.puppet.com) - The official ticketing system
  - [Developer reference](http://docs.puppet.com/references/latest/developer/) - The commented Puppet code
  - [Puppet Stats](https://puppet.biterg.io) - Puppet related metrics and stats

## Hiera

[Hiera](https://docs.puppet.com/hiera/) is Puppet's builtin key/value data lookup system, where we can store the data we use to configure our system. It has some peculiar characteristics:

  - It's hierarchical: We can configure different hierarchies of data sources and these are traversed in order to find the value of the desired key, from the level at the top, to the one at the bottom.
  This is very useful to allow granular configurations of different settings for different groups of servers

  - It has a modular backend system: data can be stored on different places, according to the used plugins, from simple Yaml or Json files, to MongoDb, Mysql, PostgreSQL, Redis and [others](https://voxpupuli.org/plugins/#hiera). In our control-repo we use the [Hiera-eyaml](hiera_eyaml.md) backend which uses plain [Yaml](http://yaml.org) files for data storage and allows encryption of the values of selected keys (typically the ones which contains passwords or secrets)

Hiera is important because it allows to assign values to the parameters of Puppet classes.

A parameter called ```server``` of a class called ```ntp```, for example, can be evaluated via a lookup of the Hiera key ```ntp::server```:

    class ntp (
      String $server = 'ntp.pool.org'
    ) { ... }

Given the above class we can override the default value for the ```server``` parameter of the class ```ntp``` with a similar entry in one of the Yaml files used in Hiera's hierarchies:

    ---
    ntp::server: 'time.nist.gov'

This is useful to cleanly separate our Puppet code, where we declare, inside classes, the resources we want to apply to our nodes, from the data which defines how these resources should be.

In Puppet 4.9, Hiera version 5 has been introduced and this is the version we use in our control-repo.


### Hiera configuration: hiera.yaml

Hiera's configuration file (```hiera.yaml```) has changed format in version 5, here's the default, which uses the core Yaml backend and has only a layer called common:

    ---
    version: 5
    hierarchy:
      - name: Common              # A level of the hierarchy. They can be more using different data sources
        path: common.yaml         # The path of the file, under the datadir, where data is stored
    defaults:
      data_hash: yaml_data        # Use the YAML backend
      datadir: data               # Yaml files are stored in the data dir of our Puppet environment/control-repo

Here's the actual structure of the hiera.yaml file used in this control-repo, it uses the Hiera-eyaml backend and has various levels in its hierarchy:

    ---
    version: 5
    defaults:
      datadir: data
      data_hash: yaml_data
    hierarchy:
      - name: "Eyaml hierarchy"
        lookup_key: eyaml_lookup_key
        paths:
          - "nodes/%{::trusted.certname}.yaml"
          - "roles/%{::pp_application}-%{::pp_role}-%{::pp_environment}.yaml"
          - "roles/%{::pp_application}-%{::pp_role}.yaml"
          - "roles/%{::pp_application}-%{::pp_environment}.yaml"
          - "roles/%{::pp_application}.yaml"
          - "roles/%{::pp_role}.yaml"
          - "locations/%{::pp_datacenter}-%{::pp_zone}.yaml"
          - "locations/%{::pp_datacenter}.yaml"
          - "locations/%{::pp_zone}.yaml"
          - "common.yaml"
          - "defaults.yaml"
        options:
          pkcs7_private_key: /etc/puppetlabs/keys/private_key.pkcs7.pem
          pkcs7_public_key:  /etc/puppetlabs/keys/public_key.pkcs7.pem

The key infos we can get from it are:

  - The eyaml-backend is used (```lookup_key: eyaml_lookup_key```)

  - It's public and private keys are stored in the directory ```/etc/puppetlabs/keys/```. They have to be copied there wherever we run Puppet to compile a catalog which uses encrypted data: typically on the PuppetMaster, on the Vagrant VMs where we use Puppet for local testing during development, and eventually also on the Vagrant VMs used in CI. These keys are not present in this control-repo (otherwise it would defy the whole concept of using encryption to protect sensitive data).

  - The Yaml files containing our Hiera data are placed in the directory data (```datadir: data```) in out control-repo/Puppet environment. So, for example, for production Puppet environment, all the YAML files are under ```/etc/puppetlabs/code/environments/production/data```

  - The hierarchy is based on several ```paths``` under the datadir. Variables are used there (```%{varname}```). Hierarchy goes from the most specific path: ```nodes/%{::trusted.certname}.yaml``` which refers to a specific node to the most generic (```defaults.yaml```) which is used as default value for keys which are not set at higher levels.

For full reference on the format of Hiera 5 configuration file, check the [Official Documentation](https://docs.puppet.com/puppet/latest/hiera_config_yaml_5.html)

### Environment and module data

Hiera 4, used from Puppet versions 4.3 to 4.8, introduced the possibility of defining, inside a module, the default values of each class parameter using Hiera.

The actual user data, outside modules, was configured by a global ```/etc/puppetlabs/puppet/hiera.yaml``` file, which defines Hiera configurations for every Puppet environment.

With Hiera 5 is possible to have environment specific configurations, so we can have a ```hiera.yaml``` inside a environment directory which may be different for each environment:

    /etc/puppetlabs/code/environments/$environment_name/hiera.yaml

So, for the ```production``` environment:

    /etc/puppetlabs/code/environments/production/hiera.yaml

This is useful to test hierarchies or backend changes before committing them to the production environment.

We can have also per module configurations, so in a NTP module, for example, we can have a:

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

this refers yaml files under the ```data``` directory of the module.

The interesting thing in this is that we have a uniform and common way to lookup for data, across the [three layers](https://docs.puppet.com/puppet/latest/hiera_layers.html): global, environment and module: each hierarchy of each layer is used to compose a "super hierarchy" which is traversed seamlessly.

In the module data is also possible to define the kind of lookup to perform for each class parameter.

Previously the lookup was always a "normal" one: the value returned is the one of the key found the first time while traversing the hierarchy.

Now (actually since Hiera 4) it's possible to specify for some parameters alternative lookup methods (for example merging all the values found across the hierarchy for the requested key). This is done in the same data files where we specify our key values, so, for example, in our ```$module_path/users/data/common.yaml``` we can have:

    lookup_options:
      # This lookup option applies to parameter 'local' of class    'users'
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

It's possible to use the ```puppet lookup``` command to query Hiera for a given key.

If we run this on our Puppet Master we can easily find out the value of a given key for the specified node:

    puppet lookup profiles --node git.lab # Looks for the profiles key on the node git.lab

If we add the ```--debug``` option we will see a lot of useful information about where and how data is looked for.

We can also use the ```lookup()``` function inside our Puppet code, it replaces (and deprecates), the old ```hiera()```, ```hiera_array()```, ```hiera_hash()``` and ```hiera_include()```.

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

Deep merge lookup, same of ```hiera_hash('users')``` with deep_merge set to true:

    lookup('users', Hash, 'deep')

Include classes found on Hiera, same of ```hiera_include('classes')```

    lookup('classes', Array[String], 'unique').include

All the above examples can be written in an expanded way. In the following example an array is merged across the hierarchies with the option to use the ```--``` prefix to **exclude** specific entries:

    lookup({
      'name'  => 'ntp_servers',
      'merge' => {
        'strategy'        => 'unique',
        'knockout_prefix' => '--',
      },
    })

Check the [official reference](https://docs.puppet.com/puppet/latest/function.html#lookup) for all the options available for the lookup function.

## Hiera Eyaml

Hiera-eyaml is an additional Hiera backend which can be used to encrypt single keys in Hiera yaml files.

We can install it using the relevant gem:

    gem install hiera-eyaml

On the Puppet server we need to do that also in Puppet environment:

    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install hiera-eyaml

To configure it we need to specify the backend in ```hiera.yaml``` and some the location of the keys used to encrypt the data:

    ---
    :backends:
      - eyaml

    :eyaml:
      :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"
      :pkcs7_private_key: /etc/puppetlabs/code/keys/private_key.pkcs7.pem
      :pkcs7_public_key:  /etc/puppetlabs/code/keys/public_key.pkcs7.pem
      :extension: 'yaml'

Before starting to encrypt data a pair of public and private keys has to be created:

    eyaml createkeys

This creates in the ```keys``` directory (relative to the current working directory) the ```private_key.pkcs7.pem``` and ```public_key.pkcs7.pem``` files. The first one should never be shared and must be managed in a safe way, for this reason the keys (at least the private one) should not be added to the control-repo git repository.

Both of these file must be placed wherever Hiera files are evaluated: that means basically all the Puppet Servers. Since we use the same repository for different datacenters and environments, the Hiera eyaml keys should be manually copied, under the directory ```/etc/puppetlabs/code/keys```, on each new Puppet Server, both the Master of Masters and the Compile Masters.

They would be needed also in Vagrant environments, but to avoid the profileration of places where keys should be shared, it's better to avoid to encrypt data in Hiera files used by machines running in Vagrant, so for examples, in the ```"datacenter/%{::datacenter}"``` layer.

### Creating encrypted keys

We can generate the encrypted value of any Hiera key with the following command:

    eyaml encrypt -l 'mysql::root_password' -s 'V3ryS3cr3T!'

This will print on stdout both the plain encrypted string and a block of configuration that we can directly copy in our yaml files as follows:

    ---
    mysql::root_password: > ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMII  [...]

Note that the value is in the format ENC[PKCS7,Encrypted_Value].

Since we have the password stored in plain text in our bash history, we should clean it using the following command:

    history | grep encrypt
    572  eyaml encrypt -l 'mysql::root_password' -s 'V3ryS3cr3T!'
    history -d 572

Alternatively we can directly edit Hiera yaml files  with the following command:

    eyaml edit hieradata/common.eyaml

Our editor of preference will open the file and decrypt the encrypted values eventually present so that we can edit our secrets in clear text and save the file again (of course, we can do this only on a machine where we have access to the private key).

To add a new encrypted key to a file we can open it with ```eyaml edit``` and add a key with a syntax like this:

    ---
    mysql::root_password: DEC::PKCS7[my_password]!

The string ```my_password``` (our password in clear text) will be encrypted once the file is saved.

To show the decrypted content of an eyaml file, we can use the following command:

    eyaml decrypt -f hieradata/common.eyaml

Since hiera-eyaml manages both clear text and encrypted values, we can use it as our only backend if we want to work only on yaml files, the configuration entry ```:extension: 'yaml'``` we have added to hiera.yaml instructs Hiera Eyaml to use files with ```.yaml``` extension, instead of the default ```.eyaml``` one.

## Trusted facts

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

Once created, trusted facts can be accessed in Puppet code with a syntax like:

    $trusted['extensions']['pp_role']

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
## Puppet external facts

There are 3 ways to add our own facts in Puppet:

  - Writing our **custom facts**, in Ruby language and adding them to the ```lib/facter``` direcctory of a module. [Details here](https://docs.puppet.com/facter/3.5/custom_facts.html)

  - Adding **external facts**, written in plain text or as executables in any language. Details later in this document.

  - Adding **trusted facts** in ```csr_attributes.yaml``` as described in [this document](trusted_facts.md)

External facts are placed in these directories:

    On Linux/*nix:
    /opt/puppetlabs/facter/facts.d/
    /etc/puppetlabs/facter/facts.d/
    /etc/facter/facts.d/

    On Windows:
    C:\ProgramData\PuppetLabs\facter\facts.d\

They are simple files that can have different formats:

  - Simple texts with .txt extensions. Facts names and their values are in ini file style:

        role=webserver
        env=prod
        zone=berlin

  - Yaml files, with yaml extension:

        ---
        role: webserver
        env: prod
        zone: berlin

  - Json files, with json extension:

        {
          "role": "webserver",
          "env": "prod",
          "zone": "berlin",
        }

   - Any command in any language. The file, with whatever extension, just has to be executable. On Windows it must have .com, .exe, .bat, .cmd, .ps1 extension).
     The command should just output the fact name(s) and its/their values:

        #!/bin/bash
        echo "role=webserver"
        echo "env=prod"
        echo "zone=berlin"

The files we create in the facts.d directory can provide one or more facts values, and they can have any name. Typically for data files that provide just one fact, the file name is the name of the fact:

    cat /etc/puppetlabs/facter/facts.d/role.txt
    role=webserver

External facts can be deployed during provisioning of the server or can be placed in the ```facts.d``` directory of a module (they are pluginsynced automatically to the client at the beginning of a Puppet run).

External facts are a very easy way to set custon facts on nodes, just consider the following points:

  - They can be potentially changed on the client just by editing the relevant fact. We may prefer to use trusted facts when we want their values to be immutable.

  - If we use the pluginsync functionality to distribute them note that they are copied as is, from Puppet server to clients, so we don't have a way to distribute different facts to different clients.
    For this reason we'll probably find ourselves adding facts that just contain data (.txt, .yaml, .json) in some alternative way (typically during the node's provisioning) and use pluginsync only for the ones that compute the result in some way (as executables ones do).


## Puppet Enterprise Console

Puppet Enterprise (PE) provides a web console which can be used for different purposes:

  - Classify nodes in the **Node Classifier**, pinning single nodes or setting matching rules to assign a node to a Node groups and defining for each Node Group the list of classes and parameters to include. Nodes classification via the console is not mandatory, and actually in our base setup it's not used.

  - Check and review the Puppet run reports for all our nodes, having insights on what has changed in the infrastructure.

  - Have an overview on the healthiness of the infrastructure and insights on what's failing.

  - Manage Puppet job tasks.

  - Have an inventory of the facts of all the managed systems.

### Infrastructure awareness

The PE console provides direct access to all the data generated by Puppet and stored on PuppetDB.

### Dashboard

One of the most useful features of the PE console is the Dashboard, here we have an immediate overview on the status and the health of the infrastructure.

We can see the nodes where Puppet is running for real, the ones where it's runnig in **noop mode** (Puppet runs, shows the changes it would do, but it doesn't actually perform any modification on the system), and the ones which are **not reporting** (Puppet has not run on the node, or has not reported back to the server, for more than one hour (default setting)).

We have also the list of the latest reports, where we can see the total number of managed resources, the number or resources changed for a change in our code (**intentional changes**), which ones were changed because Puppet brought  resource back to the desired state, after some local manual modification (**corrective changes**), the resources which failed and the total time spent by the Master to compile the catalog (**configuration retrieval**).

### Reports

Clicking on a report date, it's possible to see the full details of the relevant Puppet transaction with all the managed resources and the occurred events, with the possibility to drill down to the specific line of code where the failure occurred.

### Nodes

Clicking on a node name, we can see the detail page for that node, here, on the different tabs, we can access to a lot of information about the node:

  - The full list of the node's facts
  - All the saved reports and events for the node
  - The list of classes and parameters which are used on the node (note: only the ones deriving from the classification on PE console are included, classes included in Puppet code, on via Hiera, are not listed here)
  - A graph with al the releationships among the node's resources
