- [Puppet noop mode](#puppet-noop-mode)
    - [Setting noop from the client](#setting-noop-from-the-client)
    - [Setting noop server-side](#setting-noop-server-side)
    - [Enforcing no-noop mode](#enforcing-no-noop-mode)
    - [Puppet code deployment and application workflows](#puppet-code-deployment-and-application-workflows)

## Puppet noop mode

`Puppet` **noop mode** allows us to review the changes that `Puppet` would do on the system without actually applying them.

This is particularly useful when managing critical servers, as it allows to push to production `Puppet code` and `data` in a more controlled, safe and manageable way.

There are various ways we can enforce `noop mode` when using this `control-repo`: let's review them.

### Setting noop from the client

In any `Puppet` installation it's possible to run `Puppet` in `noop mode` by specifying the ```--noop``` option on the command line:

    puppet agent -t --noop

This applies only for that specific `Puppet run`, so if there's a ```Puppet agent``` service running in the background, that service will run `Puppet` in `normal mode`.

The noop setting can be configured and made persistent also in ```puppet.conf```:

    [agent]
    noop = true

In this `control-repo` this can be configured on `Puppet Enterprise` clients as follows:

    # We want to manage `noop mode` on clients:
    psick::puppet::pe_agent::manage_noop: true

    # We want to set noop to true
    psick::puppet::pe_agent::noop_mode: true

    # We enforce no-noop mode on the pe_agent class to be
    # able to revert our noop settings. Details in no-noop section.
    psick::puppet::pe_agent::no_noop: true

Note that this is the common and official approach to manage `noop mode` and is controlled and managed from the client, not on the server.

### Setting noop server-side

In this `control-repo` we are using the [trlinkin-noop module](https://forge.puppet.com/trlinkin/noop) which provides a function called ```noop()``` which adds the ```noop``` metaparameter to each resource.

We use this function in ```manifests/site.pp```:

    $noop_mode = lookup('noop_mode', Boolean, 'first', false)
    if $noop_mode == true {
      noop()
    }

This code sets the ```noop_mode``` variable via a ```Hiera lookup``` for the key ```noop_mode```. If it's not found on `Hiera`, then the default value is false.

If the ```noop_mode``` variable is true then ```noop``` metaparameter is added to all the resources of the catalog.

It's recommended to limit the usage of ```noop_mode``` key on `Hiera` only when necessary, for example when a massive or invasive code change has to be promoted to production and we want a safe net where we can selectively remove ```noop_mode``` to control the propagation of change.

For example when pushing to production particularly critical changes it's possible to force `noop mode` for all the servers adding in ```hieradata/common.yaml```:

    noop_mode: true

To test the actual changes we could override this in a `Hiera` `.yaml` (something like ```hieradata/env/test.yaml``` to give you an idea) which configures a subset of our servers:

    noop_mode: false

**NOTE**: this is not the typical way to manage `noop mode` in `Puppet` and when using the `Puppet Enterprise console` you will see nodes where noop is applied with this approach undef the "Nodes run in enforcement" group (and not in `noop mode`) in the dashboard. Still, checking report you will be able to notice that actually no resource is really applied and you should see eventual changes in the noop column.

Final result is the same (no resources are really applied) but they are shown differently on `PE console`.


### Enforcing no-noop mode

In some cases we might need to enforce the applications of the resources of some classes in every case, whatever is the `noop mode`.

Most of the profiles present in the `psick module` have the ```no_noop``` parameter: if set to true all the resources of the class are enforced and are applied even if `noop` is set client side.

Note that this ```no_noop``` parameter, starting form version 0.6.0 of `psick module`, does **NOT** override any more the `server side` ```noop_mode``` setting (in this way when you set `server side` `noop` you are sure that `noop` is **always enforced**).

By default ```no_noop``` is set to false and nothing changes in terms of `noop` management.

This allows us to have some server where `Puppet` runs in `noop mode` but have still some resources always applied.

In order to set ```no_noop mode``` for a class, use ```hiera data``` like:

    psick::dns::resolver::no_noop: true
    psick::hostname::no_noop: true
    psick::hosts::file::no_noop: true
    psick::puppet::gems::no_noop: true
    psick::puppet::pe_agent::no_noop: true # This is required to be able to change the noop setting client side

In case the ```no_noop``` parameter is not present in a profile, it's quite easy to add it:

    class my_class (
      [...]
      Boolean $no_noop            = false,
    ) {

      if !$::psick::noop_mode and $no_noop {
        info('Forced no-noop mode.')
        noop(false)
      }
      [...]
    }

### Puppet code deployment and application workflows

Enabling `noop mode` on some clients, the most important ones, or the whole production ones, allows us to implement some sophisticated and safe workflows for the testing and the deployment of the `Puppet code` and `data` that manage our nodes.

Some basic principles have to be considered in order to design them in the most effective way:

  - `Server side` `noop mode` if set to true, overrides any client or ```no_noop``` setting
  - Setting a class ```no_noop``` parameter to true overrides any client setting
  - We can manage via `Hiera` both server and client settings, giving us full flexibility on where to set it, still we should limit as much as possible the places where we configure it, and possibly, to avoid unnecessary confusion, not use, on regular basis, both server and client settings at the same time (exceptions below).
  - Client settings are effective after the `Puppet run` that sets them. `Server side` settings are immediately effective.

The following approach is recommended when `noop mode` is used or desired:

  - Set **`client side`** `noop mode` on the nodes where we want it (all production nodes or particular critical ones)
  - Use **`server side`** `noop mode` only when deploying big or potentially dangerous `code`/`data` changes, keep it undefined in normal conditions
  - Have a `CI pipeline` which triggers `Puppet runs` on canary nodes, also in production, enforcing one-shot ```no-noop mode```
  - In the `CI pipeline` trigger `noop Puppet runs` on the other production nodes and verify the result
  - Do not accumulate too many changes on `noop nodes`: run `Puppet` in ```no-noop mode``` on production servers as soon as possible (eventually do that in maintenance windows if you are particularly prudent).

To trigger real ```no-noop``` `Puppet runs` and apply changes on nodes normally running in `noop mode` different approaches can be used:

  - At the end of the `CI pipeline` if everything is OK trigger (manually or automatically) a ```no-noop Puppet run``` on nodes normally in `noop mode`
  - Actual execution of a ```no-noop run``` can be done via a `Puppet task` like ```psick::puppet_agent``` (it has a parameter for forcing it) or any other tool that can remotely execute ```puppet agent -t --no-noop``` on a node.
  - Via `PE-Console`, in the Run Puppet section, manage manually the remote execution of a ```no-noop Puppet run``` by clicking on the "Override noop = true configuration".

Remember that in both these last two cases, if `noop` is set `server side`, `Puppet` keeps on skipping changes on the managed node, that's why we suggest to use `server side` `noop mode` only to add a safe net when deploying massive, critical or potentially dangerous `code` and `data` changes.
In normal operations it is probably better to use `client side` `noop mode` that can be more easily overridden.
