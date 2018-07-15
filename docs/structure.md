## Control repo structure

The common elements of a `control-repo` are:

- The ```manifests``` directory where are placed the first files that the `Puppet Server` parses when compiling catalogs for clients. Here we typically have the ```site.pp``` file (but other manifests with different names can be seamlessly added) where we can set [Top scope variables](https://docs.puppet.com/puppet/latest/lang_scope.html), [Resource Defaults](https://docs.puppet.com/puppet/latest/lang_defaults.html), and eventually have [Node statements](https://docs.puppet.com/puppet/latest/lang_node_definitions.html) to define what classes should be included in our nodes (nodes classification can be done in several different ways, using the ```node``` statement is just one of them, which, incidentally, is not used here).

- The ```hieradata``` or ```data``` directory which contains [Hiera](https://docs.puppet.com/hiera/latest/) data files. The name of the directory is completely arbitrary and must match what's defined in ```hiera.yaml```. On some `control-repos` we may not have such a directory (in the rare case `Hiera` is not used, or uses external backends or its data is stored in a separated repository). In our case `Hiera` is used with the popular **Eyaml backend**, which allows storage of data in `YAML` files and the possibility to encrypt some key. The `Hiera` data files in `YAML` format are placed in the ```data``` directory.

- The ```modules``` directory contains `Puppet modules`. Typically we don't place themselves directly in our `control-repo` but define them in the ```Puppetfile``` and then deploy them with tools like [r10k](https://github.com/puppetlabs/r10k) or [Librarian Puppet](https://github.com/voxpupuli/librarian-puppet).

- Besides the ones in public modules, we need to create custom classes where we customize resources to fit our needs. In this `control-repo` they are placed in the ```site``` directory, here we have a `profile` module with all our profiles (the `Puppet classes` that actually manage different kind of services and software), and a `tools` module, mostly containing `Puppet` [defines](https://docs.puppet.com/puppet/latest/lang_defined_types.html) used in our profiles.

- The ```environment.conf``` file, which configures our environment: where the modules are placed, the caching timeout and eventually a script that returns a custom configuration version.


Besides these common locations, in our `control-repo` we have also:

- The ```vagrant``` directory contains different `Vagrant` environments with the relevant toolset that can be used to test the same `control-repo`. They are fully customizable by editing the ```config.yaml``` file in each `Vagrant` environment.

- Files for building `Docker images` locally are under the ```docker``` directory.

- [Fabric](http://www.fabfile.org) tasks are defined in the ```fabric``` directory.

- Documentation is stored under ```docs```

- The ```bin``` directory contains several scripts for various purposes. Most of them can be invoked via `Fabric`.
