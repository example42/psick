- [Introduction to Puppet](#introduction-to-puppet)
- [Anatomy of a Puppet run](#anatomy-of-a-puppet-run)
- [Learning resources](#learning-resources)

### Introduction to Puppet

`Puppet` features a **declarative Domain Specific Language (DSL)**, which expresses the **desired state** and properties of the managed resources.

**Resources** can be any component of a system, for example, packages to install, services to start, files to manage, users to create, and also custom and specific resources such as `MySQL grants`, `Apache virtual hosts`, but also `Network interfaces`, `AWS instances`, `Storage volumes` and so on.

`Puppet code` is written in **manifests**, which are simple text files with a ```.pp``` extension.

Resources can be grouped in **classes** (do not consider them as classes as in [OOP](https://en.wikipedia.org/wiki/Object-oriented_programming); they aren't). Classes and all the files needed to define the required configurations are generally placed in **modules**, which are directories structured in a standard way that are supposed to manage specific applications or a system's features (there are modules to manage `Apache`, `MySQL`, `sudo`, `sysctl`, `networking`, and so on).

When `Puppet` is executed, it first runs **facter**, a companion application, which gathers a series of variables about the system (the `IP address`, the `hostname`, the `operating system`, the `MAC address`, and so on), which are called **facts***, and are sent to the `Puppet Server`.

Facts and user defined variables can be used in manifests to manage how and what resources to provide to the clients.

When the `Puppet Server` receives a connection, it looks in its manifests (starting from the the files in ```/etc/puppetlabs/code/environments/production/manifests/site.pp```) what resources have to be applied for that client host, also called a node.

The `Puppet Server` parses all the `DSL code` and produces a **catalog** that is sent back to the client (in `JSON`, `PSON` format). The production of the catalog is often referred to as catalog **compilation**.

Once the client receives the catalog, it starts to apply all the resources declared there, irrespective of whether packages are installed (or removed), services have started, configuration  files are created or changed, and so on. The same catalog can be applied multiple times; if there are changes on a managed resource (for example, a manual modification of a configuration file), they are reverted to the state defined by `Puppet`; if the system's resources are already at the desired state, nothing happens.
This property is called **idempotence** and is at the root of the `Puppet` declarative model. Since it defines the desired state of a system, it must operate in a way that ensures that this state is obtained wherever the starting conditions and the number of times `Puppet` is applied.


### Anatomy of a Puppet run

In normal setups `Puppet` follows a `Client-Server` paradigm, on clients it runs, as ```root``` the **Puppet Agent** service, which connects to the **Puppet Server**. All the communication is done using REST-like API calls on an SSL socket; basically, it's all **HTTPS** traffic from clients to the server's port **8140/TCP**.

The first time we execute `Puppet` on a node, a X.509 **certificate** is created and then the `Puppet Server` is contacted in order to retrieve the node's catalog. The client's certificate has to be accepted (signed) by the server, using its own local `Certification Authority`(CA).

A typical `Puppet` run is composed of different phases. It's important to know them in order to troubleshoot problems:

  - Execute `Puppet` on a root shell on the client:

        client# puppet agent -t

  - Modules' plugins (whatever is present in the ```lib``` dir of a module) are synced to the node. We will see a message like:

        [client] Info: Retrieving plugin

  - The client runs ```facter``` and sends its facts to the `Puppet Server`. The client output looks like:

        [client] Info: Loading facts in /var/lib/puppet/lib/facter/... [...]

  - The `Puppet Server` looks for the client's certname (by default the [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name)) in its nodes' list.

  - The `Puppet Server` compiles the catalog for the client using its facts and the `Puppet code` and `data` it. On `Puppet Server` logs an entry like this will be added:

        [server] Compiled catalog for <client> in environment production in 8.22 seconds

  If there are syntax errors in the processed `Puppet code`, they are exposed here, and the process terminates; otherwise, the server sends the catalog to the client. On the client a text like this will be displayed:

        [client] Info: Caching catalog for <client>

  The client receives the catalog and starts to apply it locally. If there are dependency loops, the catalog can't be applied and the whole run fails. If not the client will start to apply the resources present in the catalog, beginning with a message like:

        [client] Info: Applying configuration version '1355353107'

  - All changes to the system are shown on stdout or in logs. If there are errors they are relevant to specific resources but do not block the application of other resources (unless they depend on the failed ones, in those cases a message mentioning `Skipping because of failed dependencies` will be shown.

  - At the end of the `Puppet run`, the client sends to the server a report of what has been changed. Client output:

        [client] Finished catalog run in 13.78 seconds

  - The server sends the report to a report collector (typically `PuppetDB`) for storage and later querying.


### Learning resources

Useful resources to start learning `Puppet`:

  - The website of [Puppet](http://puppet.com), the company behind
  - The official [Puppet Documentation site](http://docs.puppet.com/) -
  - [The Learning VM](https://puppet.com/download-learning-vm), based on `Puppet Enterprise`, for a guided tour in `Puppet World`
  - A list of the available [Puppet Books](https://puppet.com/resources/books)

If we have questions to ask about `Puppet` usage we can use these:

  - All the [Puppet Community](http://puppet.com/community/overview/) references
  - [Ask Puppet](http://ask.puppet.com/), the official Q&A site
  - The discussion groups on `Google Groups`: [puppet-users](https://groups.google.com/forum/#!forum/puppet-users), [puppet-dev](https://groups.google.com/forum/#!forum/puppet-dev), [puppet-security-announce](https://groups.google.com/forum/#!forum/puppet-security-announce)
  - The `IRC` `#puppet channel` on [Freenode](http://webchat.freenode.net/?channels=puppet)
  - The [Slack](https://slack.puppet.com/) `Puppet channels`

To explore and use existing `Puppet code`:

  - `Puppet modules` on [Module Forge](http://forge.puppet.com)
  - `Puppet modules` on [GitHub](https://github.com/search?q=puppet)

To inform ourselves about what happens in `Puppet World`

  - [Planet Puppet](http://www.planetpuppet.org/) - `Puppet` blogosphere
  - The [PuppetConf](http://www.puppetconf.com) website
  - The ongoing [PuppetCamps]() all over the world

To find more and deeper information:

  - [Puppet Labs tickets](https://tickets.puppet.com) - The official ticketing system
  - [Developer reference](http://docs.puppet.com/references/latest/developer/) - The commented `Puppet code`
  - [Puppet Stats](https://puppet.biterg.io) - `Puppet` related metrics and stats
