## Puppet noop mode

It's possible to run Puppet in **noop mode** which shows what are the changes that Puppet would do on the system without actually doing them.

There are various ways we can enforce noop mode: let's review them.

### Setting noop from the command line

In any Puppet installation it's possible to run Puppet in noop mode specifying the ```--noop``` option in the command line:

    puppet agent --noop

This applies only for that specific Puppet run, so if there's a Puppet agent service running in the background, that service will run Puppet in normal mode.

Also note that this approach is triggered and managed from the client.

### Setting noop via Hiera

In this control-repo we are using the trlinkin-noop module with provides a function called ```noop()``` which adds the noop metaparameter to each resource.

We use this function in ```manifests/site.pp```:

    $noop_mode = hiera('noop_mode', false)
    if $noop_mode == true {
      noop()
    }

This code sets the ```noop_mode``` variable via a Hiera lookup for the key ```noop_mode```. In if it's not found on Hiera, then the default value is false.

If the ```noop_mode``` variable is true then noop metaparameter is added to all the resources of the catalog.

It's recommended to limit the usage of noop_mode key on Hiera only when necessary.

For example when pushing to production particularly critical changes it's possible to force noop mode for all the servers adding in ```hieradata/common.yaml``` something like:

    ---
      noop_mode: true

In other cases it may make sense to add this setting to more specific layers of the hierarchy.

