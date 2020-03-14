# Pre Conditions

This folder should contain any \*.pp files that you want to be included in every test.

A common use of this is defining resources that may not exist in the catalog when you are running tests. For example, if we are using a resource that tries to restart the `pe-puppetserver` service, unless it is compiled on a Puppet Maser the `pe-puppetserver` service will not exist and the catalog will fail to compile. To get around this we can create a .pp file and define the resource like so:

``` puppet
# We are not going to actually have this service anywhere on our servers but
# our code needs to refresh it. This is to trick puppet into doing nothing
service { 'pe-puppetserver':
  ensure     => 'running',
  enable     => false,
  hasrestart => false, # Force Puppet to use start and stop to restart
  start      => 'echo "Start"', # This will always exit 0
  stop       => 'echo "Stop"', # This will also always exit 0
  hasstatus  => false, # Force puppet to use our command for status
  status     => 'echo "Status"', # This will always exit 0 and therefore Puppet will think the service is running
  provider   => 'base',
}
```

This will mean that the `pe-puppetserver` service is in the catalog for spec testing and will even allow you to try to restart it during acceptance tests without the service actually being present.

More info: https://github.com/dylanratcliffe/onceover#using-workarounds
