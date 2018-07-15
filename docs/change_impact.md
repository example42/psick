### Changes impact overview: summary of involved files and possible effects

This repository contains various files and directories, changing their contents may or may not affect our servers in different ways. We identify the following risk levels, from lower to higher:

  - [safe] Changes done here are totally safe in terms of impact on running servers
  - [limited] Changes here impact a limited number of servers or not critical elements
  - [warning] Changes may impact several servers and should be considered with care
  - [danger] Changes may have a very large impact. Be sure to be aware of what we are doing

Let's have a quick overview of the risk level related to different kind of files. Needless to say that they refer to actual changes in `Puppet code` and `data`, if we are just adding a comment we can be confident that the change won't have any effect.

  - [safe] ```README.md```, ```docs/```, ```LICENSE``` contain documentation and general information. Changes done here won't have any impact on our servers

  - [danger] ```hiera.yaml``` is the [Hiera](https://puppet.com/docs/hiera/latest/index.html) configuration file for the environment, changes here (for in the hierarchy or the used backends) may affect several systems in more or less unpredictable ways. Edit it only if we know what we are doing.

  - [danger] ```data/common.yaml```, ```data/defaults.yaml```, ```data/location/``` contain `Hiera` data which is used for all the nodes or the ones of a specific location (when not overridden in more specific layers of the hierarchy), so any change here may impact several servers. Be aware.

  - [warning] ```data/role/``` contains `Hiera data` which is used for all the nodes of the same role. These might be a few or several, according to the role. Edit with care, always considering if it's safe to rollout our change to all the nodes with this role

  - [limited] ```data/nodes/``` contains `Hiera data` for specific nodes. Here we can place nodes specific settings, which are easy to test (directly on the involved node) and have a limited impact (only the node having the name of the file we change).

  - [danger] ```manifests/``` files here impact all the nodes. Handle with care.

  - [warning] ```Puppetfile``` contains the list of the modules to add to the `control-repo`. If we add a new module we won't have any effect on nodes until we actually start to use its classes or defines. If we remove a module we'll break `Puppet runs` in all the nodes that eventually use it. When we add or remove modules, we may see on our nodes files changing at the first `Puppet run:` these are due the contents of module's plugins being synced to the clients (```pluginsync``` feature) they are normal and won't affect our servers operations.

  - [warning] ```bin/```, ```docker/```, ```vagrant/```, ```fabfile```, ```.gitlab-ci.yml``` contain scripts, configurations and settings which won't affect directly our servers but may break our `CI pipelines` or `testing environments`. Handle with relative care.

  - [warning] ```site/profiles/*``` here stay local `profiles`, `templates`, `files`, `facts`, `resource types`, `data types`.

**NOTE:** Don't be too much worried about the above dangers and warnings, though, it's normal in the life of `Puppet admin` to edit such files, just be aware of the potential impact area of our change and, always, do changes we are aware of and, when we are not fully sure of what we are doing, test our changes in `noop mode` before actually enforcing them.
